#!/usr/bin/env python

#####
#
# Written by Wes Goodhoofd -- w@wesg.ca
# Date January 21, 2019
#
# A tool to sync the message list from the ROS website
#
#####

import argparse
import datetime
import getpass
import custom_messages
import requests
from bs4 import BeautifulSoup
import urlparse, os
import re

typeMap = {
	'float32' : 'Float32',
	'float8' : 'Float8',
	'float16' : 'Float16',
	'string' : 'String',
	'int8' : 'Int8'
}

def saveMessageFile(messageName, messageProperties, package, args):
	# generate the Swift message file
	msgFolder = os.path.realpath(args.folder)

	# determine if the package folder exists
	packageFolder = os.path.join(msgFolder, package)
	if not os.path.exists(packageFolder):
		os.makedirs(packageFolder)

	# generate the file
	messageFile = os.path.join(packageFolder, "%s.swift" % messageName)
	if not os.path.exists(messageFile) or args.force:
		# create the new file and overwrite the existing one
		custom_messages.createMessageFile(messageFile, messageName, messageProperties)

if __name__ == '__main__':
	# process parameters
	parser = argparse.ArgumentParser(description='Sync messages from the ROS website')
	parser.add_argument("folder")
	parser.add_argument("--branch", "-b", action="store", default="jade-devel")
	parser.add_argument("--force", "-f", dest="force", action='store_true', default=False)
	parser.add_argument("--list", "-l", dest="page_list", action="store", default=None)
	parser.add_argument("--package", "-p", dest="package", action="store", default=None)
	args = parser.parse_args()

	# get a list of categories to download
	mainUrl = "https://github.com/ros/common_msgs/tree/%s/%s/msg"
	knownPackages = ["actionlib_msgs", "diagnostic_msgs", "geometry_msgs", "nav_msgs", "sensor_msgs", "shape_msgs", "stereo_msgs", "trajectory_msgs", "visualization_msgs"]
	types = []
	repo = "common_msgs"

	# generate the array of packages
	if args.package is not None and args.page_list is not None:
		packages = [(args.page_list, args.package)]
		repo = args.package
	else:
		packages = []
		for package in knownPackages:
			url = mainUrl % (args.branch, package)
			packages.append((url, package))

	# download the page
	for (url,package) in packages:
		print "Processing package %s" % package

		r = requests.get(url)
		if r.status_code == 200:
			pageText = r.text
			soup = BeautifulSoup(pageText, 'lxml')

			# find the links to the messages
			links = soup.find('table', {"class" : "files"}).find('tbody').findAll('a', {'class' : 'js-navigation-open'})

			msgLink = "https://raw.githubusercontent.com/ros/%s/%s/%s/msg/%s.msg"

			for link in links:
				messageLinkText = link.text
				href = link.attrs['href']
				messageSearch = re.search("(.*)\.msg", messageLinkText)

				if messageSearch is not None:
					message = messageSearch.group(1)
				else:
					continue

				msgUrl = msgLink % (repo, args.branch, package, message)

				# do some hard coding if requesting the common msg repo
				msgUrl = msgUrl.replace('/std_msgs/msg/', '/msg/')

				# now download the page to parse the actual properties
				print "Processing message %s" % message

				msgR = requests.get(msgUrl)
				if msgR.status_code == 200:
					msgText = msgR.text
					msgComponents = msgText.split("\n")

					# go through each item
					filtered = [i for i in msgComponents if i and not i.startswith("#")]

					# split into type and name
					messageProperties = []
					for messageProperty in filtered:
						componentSearch = re.search("([^\s]+)\s+([^\s]+)", messageProperty)
						if componentSearch:
							propertyName = componentSearch.group(2)
							propertyType = componentSearch.group(1)

							# check if it's a message
							typeComponents = propertyType.split('/')
							if len(typeComponents) == 2:
								propertyType = typeComponents[1]

							if propertyType[0].isupper():
								if re.search('\[\]$', propertyType):
									propertyType = propertyType.replace('[]', 'Message[]')
								else:
									propertyType += "Message"

							property = [propertyName, propertyType]
							messageProperties.append(property)

							if propertyType not in types:
								types.append(propertyType)

						# generate a file
					saveMessageFile(message+"Message", messageProperties, package, args)
				else:
					print "Page %s -- status code %d" % (msgUrl, msgR.status_code)
		else:
			print "Page %s -- status code %d" % (url, r.status_code)

	types.sort()
	print types