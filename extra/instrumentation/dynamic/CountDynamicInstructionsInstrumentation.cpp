#include <stdio.h>
#include <map>

using namespace std;

map <char *, int> dynamicInstCounter;

void Record(char* opcode, int count)
{
	dynamicInstCounter[opcode] += count;
    printf("\nHello, current count:\n");
	int sum = 0;
	for(map<char*, int>::iterator iterator = dynamicInstCounter.begin(); iterator != dynamicInstCounter.end(); ++iterator) {
		printf("%s\t%d\n", iterator->first, iterator->second);
		sum += iterator->second;
	}
	printf("%s\t%d\n", "TOTAL", sum);
}

void PrintInstructionCount()
{
	int sum = 0;
	for(map<char*, int>::iterator iterator = dynamicInstCounter.begin(); iterator != dynamicInstCounter.end(); ++iterator) {
		printf("%s\t%d\n", iterator->first, iterator->second);
		sum += iterator->second;
	}
	printf("%s\t%d\n", "TOTAL", sum);
}

