#!/bin/bash
MAX_POINTS=$1
score=0
if [ $# == 0 ]; then
   echo "Usage:  $0 MAXPOINTS "
     exit
else 
   mkdir students
   tar=find / -type d -name "students.tar.gz"
   mv $tar /home
   tar -xvf students.tar.gz -C ./students
   touch outputOfStudent.txt

 for file in students/*;
   do
    student_name=`basename $file`
    echo "Processing $student_name..."
      hmw=`find $file -type f -name "[Hh]omework1.sh" `
       
    if [ -z $hmw ];
    then
       echo "$student_name did not turn in the assignment in the correct format"
       echo "$student_name has earned a score of 0 / $MAX_POINTS "
       echo " "
    else
      `$hmw > $outputOfStudent.txt`
      
    different_lines=`diff $outputOfStudent.txt  expected.txt | grep "^[<>]" | wc -l`
    comments=`grep "#" $hmw |wc -l `
   
  if [ $different_lines -lt $MAX_POINTS ]; then 
     if [ $comments -gt 2 ];then
       score=$(( $MAX_POINTS - $different_lines + 5 ))
      else 
       score=$(( $MAX_POINTS - $different_lines - 5 ))
     fi
      else
      score=0
  fi
   
  if [  $different_lines -lt $MAX_POINTS ]; then
    if [ $different_lines == 0 ]; then
       echo "$student_name has correct output"
     else
       echo "$student_name has incorrect output ($different_lines do not match)"
    fi  
  fi

     echo "$student_name has $comments lines with comments"
     echo "$student_name has earned a score of $score / $MAX_POINTS"  
     echo " "
 
 fi
done
fi
 
  
