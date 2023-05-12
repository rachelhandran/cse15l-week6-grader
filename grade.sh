CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area
rm -rf compile-error.txt
rm -rf student-test-output.txt

mkdir grading-area

# Code needed: Student java, and Junit
git clone $1 student-submission
echo 'Finished cloning'
ls

# if statement checking if file name is correct
# "Wrong file submitted, check file try again.."
# use exit to exit script early exit 1
#cd grading-area
cd student-submission
ls
if [[ -e "ListExamples.java" ]]
then 
    cp ListExamples.java ../grading-area
    echo 'Successfully copied ListExamples to grading-area'
fi
cd ../grading-area
echo "---------------"
ls
# Load in test code .java
echo "---------------"
echo "Copying test files and libraries..."
cp ../TestListExamples.java .
cp -r ../lib/ .

ls

# Compile student file with javac from appropriate dirs
# If compling fails, exit code 2, feedback
# Use output redirection 2>

javac ListExamples.java 2> compile-error.txt 

temp=$?
if [[ temp -ne 0 ]]
then
    cat compile-error.txt 
    echo "Compile Error. Recheck your files. Exited with code " $temp
    exit
fi

echo "Student file compiled successfully!"


# Run code

# javac -cp ../libs/junit-4.13.2.jar:../libs/hamcrest-2.2.jar:. <file>.java 
# java -cp ../libs/junit-4.13.2.jar:../libs/hamcrest-2.2.jar:. org.junit.runner.JUnitCore <file>
echo "Compling tests..."
javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 

echo "Test file compiled successfully!"

echo "Running test files..."
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > student-test-output.txt

grep -o 'Tests run:..' ./student-test-output.txt > student-test-runs.txt
grep -o 'Failures:..' ./student-test-output.txt > student-failures.txt
cat student-test-runs.txt
cat student-failures.txt

run=$(grep -Eo '[0-9]+' student-test-runs.txt)
fails=$(grep -Eo '[0-9]+' student-failures.txt)
echo $run
echo $fails

let $fails/$run

# do math and print

# compile error check
# use output redirect
# use exit code 3

# if it runs do normal standard output redirection and print that file


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
