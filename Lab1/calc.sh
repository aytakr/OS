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
  if [[ $4 -ne 4 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После calc введите sum/sub/mul/div и два целых числа"
    argumentError
  fi
  re='^[0-9]+$'
  if ! [[ "$2" =~ $re && "$3" =~ $re ]]
  then
    echo "Ошибка - Неверный третий или четверный аргумент. Выберите в качестве третьего и четвертого аргументов целое число"
    argumentError
  fi
  if [[ "$1" = "div" && $3 -eq 0 ]]
  then
    echo "Ошибка - деление на ноль невозможно"
    mathError
  fi
  if [[ "$1" != "sum" && "$1" != "sub" && "$1" != "mul" && "$1" != "div" ]]
  then
    echo "Ошибка - Неверный второй аргумент. Выберите вторым аргументом sum/sub/mul/div"
    argumentError
  fi
  res=$($1 $2 $3)
  echo "$res"
}
