using System;
using System.IO;
using System.Linq;
using fat.utils;

namespace fat.FAT
{
    public class FAT
    {
        private BootSector_BPBStructure _bpbStructure;
        private FAT12_16_BootSector _fat1216;
        private FAT32_BootSector _fat32;
        private int volsize = 0;
        private FatType _fatType;

        public FAT( short BytsPerSec)
        {
            _bpbStructure = new BootSector_BPBStructure(FatType.Fat16, BytsPerSec);
            _fat1216 = new FAT12_16_BootSector("");
            _fat32 = new FAT32_BootSector("");
        }
        public void CreateFat(string filepath,FatType type)
        {
            _fatType = type;
            calcFatsz();
            CalcClusterAmount();
            if (type == FatType.Fat12 || type == FatType.Fat16)
            {
                 byte[] BootSector = MarshallingHelper.StructToBytes(_bpbStructure);
                 byte[] Fat12_16 = MarshallingHelper.StructToBytes(_fat1216);
                 File.WriteAllBytes(filepath, BootSector.Concat(Fat12_16).ToArray());
            }
            else
            {
                byte[] BootSector1 = MarshallingHelper.StructToBytes(_bpbStructure);
                byte[] Fat32 = MarshallingHelper.StructToBytes(_fat32);
                File.WriteAllBytes(filepath, BootSector1.Concat(Fat32).ToArray());
            }
        }
        
        void calcFatsz() {
            int RootDirSectors = (((BitConverter.ToInt16(_bpbStructure.BPB_RootEntCnt) * 32)) - 1) / BitConverter.ToInt16(_bpbStructure.BPB_BytsPerSec);
            int TmpVal1 = (volsize - (BitConverter.ToInt16(_bpbStructure.BPB_RsvdSecCnt) + RootDirSectors));
            int TmpVal2 = (256 * BitConverter.ToInt16(_bpbStructure.BPB_SecPerClus)) + 2;
            if(_fatType == FatType.Fat16) {
                TmpVal2 = TmpVal2 / 2;
            }
            int FATSz = (TmpVal1 + (TmpVal2 - 1)) / TmpVal2;
            if(_fatType == FatType.Fat32) {
                _bpbStructure.BPB_FATSz16 = BitConverter.GetBytes((short) 0);
                _fat32.BPB_FATSz32 = BitConverter.GetBytes(FATSz);
            } else {
                _bpbStructure.BPB_FATSz16 = BitConverter.GetBytes(FATSz & 0xffff);
            }
        }

        void CalcClusterAmount()
        {
            int RootDirSectors = (((BitConverter.ToInt16(_bpbStructure.BPB_RootEntCnt) * 32)) - 1) / BitConverter.ToInt16(_bpbStructure.BPB_BytsPerSec);
            Int32 FATSz = 0;
            Int32 TotSec = 0;
            if(BitConverter.ToInt16(_bpbStructure.BPB_FATSz16) != 0) {
                FATSz = BitConverter.ToInt16(_bpbStructure.BPB_FATSz16);
                TotSec = BitConverter.ToInt16(_bpbStructure.BPB_TotSec16);
            } else {
                FATSz = BitConverter.ToInt32(_fat32.BPB_FATSz32);
                TotSec = BitConverter.ToInt32(_bpbStructure.BPB_TotSec32);
            }
            long FirstDataSector = BitConverter.ToInt16(_bpbStructure.BPB_RsvdSecCnt) + (2 * FATSz) + RootDirSectors;

            long DataSec = TotSec - FirstDataSector;

            long CountofClusters = DataSec / BitConverter.ToInt16(_bpbStructure.BPB_SecPerClus);
            
            Console.WriteLine($"Здеся мы выводим и оно равно = {CountofClusters}");

        }
    }
}