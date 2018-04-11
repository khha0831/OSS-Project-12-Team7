#include <stdio.h>

int add(int a, int b);
int minus(int a, int b);
int mul(int a, int b);
int div(int a, int b);

int main() {
  int num1, num2;
  int result = 0;
  char ch;
  
  printf("Enter number : ");
  scanf("%d", &num1);
  
  printf("Enter number : ");
  scanf("%d", &num2);
  
  printf("Enter +, -, *, / : ");
  scanf("%s", &ch);

  switch(ch)
  {
      case'+';
      printf("%d %c %d =%d\n",num1,ch,num2,add(num1,num2));
      result=add(num1,num2);
      
      case'-';
      printf("%d %c %d =%d\n",num1,ch,num2,add(num1,num2));
      result=mminus(num1,num2);
      
      case'*';
      printf("%d %c %d =%d\n",num1,ch,num2,add(num1,num2));
      result=mul(num1,num2);
      
      case'/';
      printf("%d %c %d =%d\n",num1,ch,num2,add(num1,num2));
      result=div(num1,num2);
      
      system("pause");
}

int add(int a, int b){
  int result1;
  
  result = a + b;
  return result1;
}

int minus(int a, int b){
  int result1;
  
  result1 = a - b;
  return result1;
}

int mul(int a, int b){
  int result1;
  
  result1 = a * b;
  return result1;
}

int div(int a, int b){
  int result1;
  
  result1 = a / b;
  return result1;
}
