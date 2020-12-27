using System;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using fat.FAT;
using fat.utils;

namespace fat
{
    class Program
    {
        static void Main()
        {

            FAT.FAT fat = new FAT.FAT(512);
            fat.CreateFat("C:\\Users\\Freel\\RiderProjects\\Solution1\\txt.img",FatType.Fat12);


            // // byte[] BPB_RootEntCnt, BPB_BytsPerSec, FATSz, TotSec, BPB_ResvdCnt, BPB_NumFATs;
            // //
            // // byte[] BootSector = MarshallingHelper.StructToBytes(new BootSector_BPBStructure(FatType.Fat16));
            // // byte[] Fat12_16 = MarshallingHelper.StructToBytes(new FAT12_16_BootSector(""));
            // // File.WriteAllBytes("fat16.img", BootSector.Concat(Fat12_16).ToArray());
            // //
            // // byte[] BootSector1 = MarshallingHelper.StructToBytes(new BootSector_BPBStructure(FatType.Fat32));
            // // byte[] Fat32 = MarshallingHelper.StructToBytes(new FAT32_BootSector(""));
            // // File.WriteAllBytes("fat32.img", BootSector.Concat(Fat32).ToArray());
            // byte[] bootSector, fat;
            // string volumeLabel;
            //
            //
            // Console.WriteLine("Выбери тип FAT:\n0 - FAT12\n1 - FAT16\n2 - FAT32");
            // int key = Convert.ToInt32(Console.ReadLine());
            // switch (key)
            // {
            //     case 0:
            //         Console.WriteLine("\nВыбери волум лэйбл");
            //         volumeLabel = Console.ReadLine();
            //         if (volumeLabel == null || volumeLabel.Length > 11)
            //             throw new Exception("ЧЕл ты...");
            //         while (volumeLabel.Length != 11)
            //             volumeLabel += " ";
            //         Console.WriteLine()
            //         break;
            //     case 1:
            //         break;
            //     case 2:
            //         break;
            //     default:
            //         Console.WriteLine("Oh, you think you are smart? Now check this out:");
            //         System.Environment.Exit(-1);
            //         break;
            // }
        }
    }
}