defmodule Calc do
def main do
  do_stuff("Y")
end

def do_stuff(checker) do
  #IO.puts("checker is #{checker}")
  my_str = IO.gets("enter your expression?")
  my_str =  String.replace(my_str, "\n", "")
  operandStack = []
  operatorStack = []
  eval(String.split(my_str, " "), operandStack, operatorStack)

end

def eval(expression, operandStack, operatorStack) do
  if (expression == nil) do
    #IO.puts("oh bc yaha aa gaya ")
    #IO.inspect(expression)
    if (length(operatorStack)!= 0) do
    {op1, operatorStack} =pop(operatorStack)
    {var1, operandStack} = pop(operandStack)
    {var2, operandStack} = pop(operandStack)
    #IO.puts("entered inside the operator stack thingy")
    result = applyOperation(op1, var1, var2)
    operandStack = push(operandStack, result)
    eval(expression, operandStack, operatorStack)
  else
      #IO.inspect("operand stack is")
      #IO.inspect(operandStack)
      {result, _ } = pop(operandStack)
      IO.puts(result)
      checker = IO.gets("do you want to continue? Y/N ")
      checker = String.replace(checker, "\n", "")
      if (checker == "N") do
        :ok
      else
        do_stuff("Y")
      end

  end
else

  if(length(expression) != 0) do
    {head , tail} = pop(expression)
    if(head != "+" and head != "-" and head !="*" and head !="/") do
      operandStack = push(operandStack, head)
      #IO.inspect(operandStack)
    else
      #IO.puts("entered here")
      if(length(operatorStack) == 0) do
        operatorStack = push(operatorStack, head)
      else
        precendance_check = getPrecedance(head, List.first(operatorStack))
        if(precendance_check == true) do
          {op1, operatorStack} =pop(operatorStack)
          {var1, operandStack} = pop(operandStack)
          {var2, operandStack} = pop(operandStack)
          #IO.puts("op1 is #{op1}")
          #IO.puts("var1 is #{var1}")
          #IO.puts("var2 is #{var2}")
          result = applyOperation(op1, var1, var2)
          operandStack = push(operandStack, result)
          operatorStack = push(operatorStack, head)
        else
            operatorStack = push(operatorStack, head)
        end
      end

      end

    end
eval(tail, operandStack, operatorStack)
end
end

def pop(stack) do
    if(length(stack) == 1) do
      [last_in] = stack
      {last_in, []}
    else
      [last_in | rest] = stack
      {last_in, rest}
    end

end

def push(stack, item) do
    [item | stack]
  end

def applyOperation(op, var1, var2) do
  if(op == "+") do
    {var1, _} = Integer.parse(var1)
    {var2, _} = Integer.parse(var2)
    result = var1 + var2
  end
  if(op == "-") do
    {var1, _} = Integer.parse(var1)
    {var2, _} = Integer.parse(var2)
    result = var2 - var1
  end
  if(op =="*") do
    {var1, _} = Integer.parse(var1)
    {var2, _} = Integer.parse(var2)
    result = var1 * var2
  end
  if(op == "/") do
    {var1, _} = Integer.parse(var1)
    {var2, _} = Integer.parse(var2)
    result = var2 / var1
  end
Integer.to_string(result)
end

def getPrecedance(op1, op2) do
  #IO.puts("op1 is #{op1}")
  #IO.puts("op2 is #{op2}")
 if (op2 == "("  or op2==")") do
   false
 end
 #IO.puts("op1 is #{op1}")
 #IO.puts("op2 is #{op2}")
 if ((op1 == "*" || op1 == "/") && (op2=="+" || op2 =="-")) do
          false
        else
          true
        end
end

end
