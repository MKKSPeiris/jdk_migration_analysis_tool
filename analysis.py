#!/usr/bin/python

import sys
import os
from os import listdir
from os.path import isfile, join

htmlLocation = sys.argv[1]
classList = report = list()
baseLocation = os.getcwd()
classLocation = baseLocation + "/java82java11"

classFiles = [f for f in listdir(classLocation) if isfile(join(classLocation, f))]

classMap = {}
classMap["charsets.txt"] = "Charset class dependencies"
classMap["deploy.txt"]   = "Deploy class dependencies"
classMap["javaws.txt"] = "JavaWS class dependencies"
classMap["jce.txt"] = "JCE class dependencies"
classMap["jfr.txt"] = "JFR class dependencies"
classMap["jsse.txt"] = "JSSE class dependencies"
classMap["jfxswt.txt"] = "JFxSWT class dependencies"
classMap["management-agent.txt"] = "Management agent class dependencies"
classMap["plugin.txt"] = "Plugin class dependencies"
classMap["resources.txt"] = "Resources class dependencies"
classMap["rt.txt"] = "Java runtime class dependencies"



with open(htmlLocation) as f:
    htmlString = f.read()
print("\n***** Analysis begins *****")
for fileName in classFiles:
    with open(classLocation + "/" + fileName) as f:
        classList = f.readlines()
    print("Checking for : " + classMap[fileName] )
    for classPath in classList:
        if (classPath.split("."))[0].replace("/", ".") in htmlString:
            print("\033[1;33m Warning :" + classPath + "\033[0;0m")
            report.append(classPath)
        else:
            pass

if not os.path.exists(baseLocation + "/reports"):
    os.makedirs(baseLocation + "/reports")
    print("Report directory created in :" + baseLocation + "/reports")
else:
    print("Report directory already exists in :" + baseLocation + "/reports")

with open(baseLocation + "/reports/report.txt", 'w') as f:
    f.write("".join(report))
print("***** Search finished *****")
