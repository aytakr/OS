#! /usr/bin/env bash
function noFileError {
  exit -1
}
function accessError {
  exit -2
}
function argumentError {
  exit -3
}
function mathError {
  exit -4
}
function noDirectoryError {
  exit -5
}
function checkFile {
  if ! [[ -e $1.sh ]]
  then
    echo "Ошибка - нет файла $1.sh"
    noFileError
  fi
  if ! [[ -r $1.sh ]]
  then
    echo "Ошибка - недостаточно прав для запуска $1.sh"
    accessError
  fi
} #Файлы .sh
function checkUsingFile {
  if ! [[ -e $1 ]]
  then
    echo "Ошибка - нет файла $1"
    noFileError
  fi
  if ! [[ -r $1 ]]
  then
    echo "Ошибка - недостаточно прав для запуска $1"
    accessError
  fi
} #Файлы-аргументы
case $1 in
calc)
  checkFile $1
  . ./calc.sh
  calc $2 $3 $4 $#
  exit 0
;;
search)
  checkFile $1
  . ./search.sh
  search $2 $3 $#
  exit 0
;;
reverse)
  checkFile $1
  . ./reverse.sh
  rev $2 $3 $#
  exit 0
;;
strlen)
  checkFile $1
  . ./strlen.sh
  strlen $2 $#
  exit 0
;;
log)
  checkFile $1
  . ./log.sh
  log $#
  exit 0
;;
exit)
  checkFile $1
  . ./exit.sh
  ex $#
;;
help)
  checkFile $1
  . ./help.sh
  help $#
  exit 0
;;
interactive)
  checkFile $1
  . ./interactive.sh
  interactive $#
  exit 0
;;
*)
  if ! [[ -e "help" ]]
  then
    echo "Ошибка - нет файла help"
    noFileError
  fi
  if ! [[ -r "help" ]]
  then
    echo "Ошибка - недостаточно прав для запуска help"
    accessError
  fi
  . ./help
  help
;;
esac
