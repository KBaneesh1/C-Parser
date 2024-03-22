#include <stdio.h>

int main()
{
    int a=10;
    if(a>=11)
    {
        while(a==10)
        a=10;
    }
    else
        a=3;

    switch (a){
        case 1:
            a= a-10;
          break;
        case 2:
            b = b-10;
            break;
        default:
            a=a+1;
            break; 
    }
    
}