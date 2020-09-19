function sum {
  echo $(( $1 + $2 ))
}
function sub {
  echo $(( $1 - $2 ))
}
function mul {
  echo $(( $1 * $2 ))
}
function div {
  echo $(( $1 / $2 ))
}
function calc {
  if [[ "$1" = "interactive" ]] #интерактивный режим
  then
    if [[ -n $5 || -z $2 || -z $3 || -z $4 ]]
    then
      echo -e "\033[31mОшибка - неправильное количество аргументов. После calc введите sum/sub/mul/div и два целых числа\033[0m"
      argumentError_int
      return $?
    fi
    re='^-?[0-9]+$'
    if ! [[ "$3" =~ $re && "$4" =~ $re ]]
    then
      echo -e "\033[31mОшибка - Неверный третий или четверный аргумент. Выберите в качестве третьего и четвертого аргументов целое число\033[0m"
      argumentError_int
      return $?
    fi
    if [[ "$2" = "div" && $4 -eq 0 || "$2" = "div" && $4 -eq -0 ]]
    then
      echo -e "\033[31mОшибка - деление на ноль невозможно\033[0m"
      mathError_int
      return $?
    fi
    if [[ "$2" != "sum" && "$2" != "sub" && "$2" != "mul" && "$2" != "div" ]]
    then
      echo -e "\033[31mОшибка - Неверный аргумент действия. Введите sum/sub/mul/div\033[0m"
      argumentError_int
      return $?
    fi
    res=$($2 $3 $4)
    echo "$res"
  else #неинтерактивный режим
    if [[ $4 -ne 4 ]]
    then
      echo -e "\033[31mОшибка - неправильное количество аргументов. После calc введите sum/sub/mul/div и два целых числа\033[0m"
      argumentError
    fi
    re='^-?[0-9]+$'
    if ! [[ "$2" =~ $re && "$3" =~ $re ]]
    then
      echo -e "\033[31mОшибка - Неверный третий или четверный аргумент. Выберите в качестве третьего и четвертого аргументов целое число\033[0m"
      argumentError
    fi
    if [[ "$1" = "div" && $3 -eq 0 || "$1" = "div" && $3 -eq -0 ]]
    then
      echo -e "\033[31mОшибка - деление на ноль невозможно\033[0m"
      mathError
    fi
    if [[ "$1" != "sum" && "$1" != "sub" && "$1" != "mul" && "$1" != "div" ]]
    then
      echo -e "\033[31mОшибка - Неверный второй аргумент. Выберите вторым аргументом sum/sub/mul/div\033[0m"
      argumentError
    fi
    res=$($1 $2 $3)
    echo "$res"
  fi
}
