defmodule Calc do
def main do
  my_str = IO.gets("")
  err = try do
    eval(my_str)
    rescue
    ArithmeticError -> "Can't divide by zero"
    MatchError -> "incosistent expression provided"
    CondClauseError -> "incosistent expression provided"
  end
  if(err != :ok) do
    IO.puts("#{err}")
  end
    main()
end

#Eval function for calculating the expression

def eval(my_str) do
  my_str = my_str |>String.replace("\n", "")
                  |>String.replace("\t", "")
                  |>String.replace("\r", "")
                  |>String.replace(" ","")
                  |>String.split("")
                  |>Enum.map(fn(x) ->
                      if(x == "") do
                          x ="__"
                      else
                          result =Integer.parse(x)
                            if(result != :error) do
                                x
                            else
                              if x == "." do
                                x
                                else
                                x = "%" <> x <> "%"
                              end
                            end
                        end
                    end)
                  |> List.to_string()
                  |> String.replace("__", "")
                  |> String.split("%")
  operandStack = []
  operatorStack = []
  calculate(my_str, operandStack, operatorStack)

end

#helper function for eval that calls itself recursively in order to
#evaluate operands and operations present on two stacks

def calculate(expression, operandStack, operatorStack) do
  if (expression == nil) do
    if (length(operatorStack)!= 0) do
    {op1, operatorStack} =pop(operatorStack)
    {var1, operandStack} = pop(operandStack)
    {var2, operandStack} = pop(operandStack)
    result = applyOperation(op1, var1, var2)
    operandStack = push(operandStack, result)
    calculate(expression, operandStack, operatorStack)
  else
      {result, _ } = pop(operandStack)
      {resultant, decimal} = Integer.parse(result)
      if(decimal != ".0") do
        {resultant, _ }= Float.parse(result)
      end
      resultant
  end
else
#if expression is not nil
  if(length(expression) != 0) do
    {head , tail} = pop(expression)
    if(head != "") do
    if(head != "+" and head != "-" and head !="*" and head !="/" and head != "(" and head !=  ")") do
      operandStack = push(operandStack, head)
    else
      #parenthesis evaluation
      if (head == "(") do
        operatorStack = push(operatorStack, head)
      end

      if (head == ")") do
        {operatorStack, operandStack} = evalParens(operatorStack, operandStack)
      else

      if(length(operatorStack) == 0) do
        operatorStack = push(operatorStack, head)
      else
        {:ok, precendance_check} = getPrecedance(head, List.first(operatorStack))

        if(precendance_check == "yes") do
          {op1, operatorStack} =pop(operatorStack)
          {var1, operandStack} = pop(operandStack)
          {var2, operandStack} = pop(operandStack)
          result = applyOperation(op1, var1, var2)
          operandStack = push(operandStack, result)
          operatorStack = push(operatorStack, head)
        else
            operatorStack = push(operatorStack, head)
        end
      end
    end
      end
    end

    end
calculate(tail, operandStack, operatorStack)
end
end

#helper function that act as pop operation in a stack

def pop(stack) do
    if(length(stack) == 1) do
      [last_in] = stack
      {last_in, []}
    else
      [last_in | rest] = stack

      {last_in, rest}
    end

end

#helper function that act as push operation on a stack

def push(stack, item) do
    [item | stack]
  end

#helper function that applies the given operation on given operands

def applyOperation(op, var1, var2) do
  result = cond do
  (op == "+") ->
    {var1, _} = Float.parse(var1)
    {var2, _} = Float.parse(var2)
    var1 + var2
  (op == "-") ->
    {var1, _} = Float.parse(var1)
    {var2, _} = Float.parse(var2)
    var2 - var1
  (op == "*") ->
    {var1, _} = Float.parse(var1)
    {var2, _} = Float.parse(var2)
    var1 * var2
  (op == "/") ->
    {var1, _} = Float.parse(var1)
    {var2, _} = Float.parse(var2)
    var2 / var1
  end

  if(is_integer(result)) do
    Integer.to_string(result)
  else
    if(is_float(result)) do
      Float.to_string(result)
    end
  end
end

#helper function that calculates precedance of operations

def getPrecedance(op1, op2) do
  cond do
     ((op1 == "*" || op1 == "/") && (op2 == "+" || op2 == "-")) ->   {:ok, "no"}
     (op2 == "("  or op2 ==")")  -> {:ok, "no"}
      true ->  {:ok, "yes"}
  end
end

#helper function for evaluating parenthesis

def evalParens(operatorStack, operandStack) do
      {op1, operatorStack} = pop(operatorStack)
      if (op1 == "(") do
        operatorStack = operatorStack -- ["("]
        {operatorStack, operandStack}
      else
        {var1, operandStack} = pop(operandStack)
        {var2, operandStack} = pop(operandStack)
        result = applyOperation(op1, var1, var2)
        operandStack = push(operandStack, result)
        evalParens(operatorStack, operandStack)
      end
end
end
