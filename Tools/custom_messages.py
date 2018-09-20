#!/usr/bin/env python

#####
#
# Written by Wes Goodhoofd -- w@wesg.ca
# Date September 19, 2018
#
# A tool to generate ROS messages by accepting parameters
#
#####

import argparse
import datetime
import getpass


if __name__ == '__main__':
	# process parameters
	parser = argparse.ArgumentParser(description='Generate custom ROS messages.')
	parser.add_argument("class_name")
	parser.add_argument("variables", nargs='+')
	args = parser.parse_args()

	# process the variables
	variables = []
	for entry in args.variables:
		variables.append(entry.split(':'))

	now = datetime.datetime.now()

	# generate the Swift placeholders

	placeholders = {
		'class_name' : args.class_name,
		'author' : getpass.getuser(),
		'date' : "%02d-%02d-%d" % (now.year, now.month, now.day),
		'init' : ''
	}

	instanceVariables = []
	mappingVariables = []
	initVariables = []

	for variable in variables:
		instanceLine = "public var %s: %s" % (variable[0], variable[1])

		# handle the init case
		if "message" in variable[1].lower():
			initLine = "%s = %s()" % (variable[0], variable[1])
			initVariables.append(initLine)
			instanceLine += "?"

		if "[" in variable[1] or "]" in variable[1]:
			instanceLine += " = ["+variable[1]+"]()"
		elif "float" in variable[1].lower() or "int" in variable[1].lower():
			instanceLine += " = 0"
		elif "bool" in variable[1].lower():
			instanceLine += " = false"

		instanceVariables.append(instanceLine)
		mappingVariables.append("%s <- map[\"%s\"]" % (variable[0], variable[0]))


	if len(instanceVariables) > 1:
		placeholders['variables'] = "\n\t".join(instanceVariables)
	else:
		placeholders['variables'] = instanceVariables[0]

	if len(instanceVariables) > 1:
		placeholders['mapping'] = "\n\t\t".join(mappingVariables)
	else:
		placeholders['mapping'] = mappingVariables[0]

	if len(initVariables) > 0:
		initMethod = "\n\tpublic override init() {\n\t\tsuper.init()\n\t\t"
		initMethod += "\n\t".join(initVariables)
		initMethod += "\n\t}\n\t"
		initMethod += "public required init?(map: Map) {\n\t\tsuper.init(map: map)\n\t}"

		placeholders['init'] = initMethod

	# load the blank message
	with open('BlankMessage.swift', 'r') as myfile:
	  messageContent = myfile.read()

	# replace the placeholders
	if messageContent is not None:
		for key,value in placeholders.items():
			messageContent = messageContent.replace('['+key+']', value)

	# save the file
	text_file = open(args.class_name+".swift", "w")
	text_file.write(messageContent)
	text_file.close()