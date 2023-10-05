#!/bin/python3
# -*- coding: utf-8 -*-

#
# Modules to import
#
import random
import csv
import os

#
# Global var
#
lines = []
score = 0
chances = 3

#
# User functions
#
def load_data():
	with open('data/bingju.csv') as csvfile:
		reader = csv.reader(csvfile, delimiter=';')
		for row in reader:
			lines.append(row)

def random_sent():
	number = random.randint(0, len(lines))
	return number

def print_correction(line_number, sent):
	filename = 'data/xiugai/' + str(line_number + 1) + '.txt'
	if os.path.isfile(filename):
		with open(filename, 'r') as f:
			print(f.read())
		answer=input("您想改解释吗？")
		if answer == "y":
			os.system("xdg-open " + filename)
	else:
		answer=input("这道题还没有解释。是否加一个解释？")
		if answer == "y":
			os.system('echo "\t原句：" >> ' + filename)
			os.system('echo "' + sent + '" >> ' + filename)
			os.system('echo "\n\t解释：\n" >> ' + filename)
			os.system('echo "\n\t修改：\n" >> ' + filename)
			os.system('echo "\n\t新句：\n" >> ' + filename)
			os.system("xdg-open " + filename)

def main():
	load_data()
	answer = ""
	global score
	global chances
	while answer != "q" and chances > 0:
		number = random_sent()
		sent = lines[number]
		print("\n", sent[1])
		answer=input("\n对：o\n错：x\n退出游戏：q\n")
		if sent[0] != answer:
			print("\n可惜，答案是", sent[0])
			chances -= 1
		else:
			print("\n回答正确！")
			score += 1
		if sent[0] == 'x':
			print_correction(number, sent[1])
		print("\n您剩下的机会：", chances)
		print("您的分数是：", score)
		

#
# Main function
#
if __name__ == "__main__":
	main()
