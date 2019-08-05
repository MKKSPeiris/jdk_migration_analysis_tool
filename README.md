# jdk_migration_analysis_tool

Our team introduced this "jdk migration analysis tool" to check whether there are any "Java 11 OpenJDK" unsupported class dependencies exists in a service before moving from "Oracal Java 8".

- Motivation : Its hard and sometimes impossible to manually find missing or unsupported dependencies in a service when we do the migration.
Even if you attempt to do this manually,its just a huge time consuming task and there is a possibility to miss some of them as well.

- Goal : Automatically scans all Java 11 unsupported class dependencies accurately and faster without missing any.

- Output :  List of java 11 unsupported dependencies that are contained in the service project.(as a report)

**How to use:** 

**1.** Clone this repository into your local machine.

**2.** Open a terminal and locate cloned "jdk_migration_analysis_tool" file location and run "scan.sh" using "./scan.sh"

-When you running this tool first time,i will automatically download `tattletale-1.1.2.Final`. 

**3.** Give your service project directory path and press enter

   ie : /home/shashika/work/protocol-tpb
   
Make sure that service directory contains "target/docker" directories as well.if it is not,build docker image of the service using "sbt docker:publishLocal.

**4.** When search finished, you can get report.txt from reports directory path

  ie : /home/shashika/Desktop/jdk_migration_analysis_tool/reports/report.txt

**Tip :** Warning messages indicates java 11 unsupported classes that found while searching.

If you do have any suggestions or improvements that you think we can add into this tool, Please feel free to reach us (Hippogriff).
