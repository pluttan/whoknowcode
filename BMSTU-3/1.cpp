#include <string.h>
#include <iostream>
#include <stdio.h>

using std::string, std::cout;
string rec(string str, int word, int size);

int main()
{
    string i = "я есть миша";
    cout << i;
    cout << rec(i, 0, 21);
}

string rec(string str, int word, int size)
{
    cout << word;
    if (word >= size)
        return str;
    int oldWord = word;
    while (str[word] != ' ' && word <= size)
    {
        word += 1;
    }
    cout << word << " " << oldWord;
    int i = 0;
    while (i < ((word - oldWord) / 2))
    {
        str[oldWord + i] += str[word - i];
        str[oldWord + i] = str[word - i] - str[oldWord + i];
        str[word + i] = str[word - i] - str[oldWord + i];
        i++;
    }
    rec(str, word + 2, size);
}