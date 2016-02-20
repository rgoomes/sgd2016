import sys

file_name = sys.argv[1]

with open(file_name) as f:
	content = f.readlines()

for i in range(len(content)):
	print content[i][:-2]
