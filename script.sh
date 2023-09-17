while getopts u:a: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        a) age=${OPTARG};;
    esac
done


mkdir builder
cd $PWD/builder
echo "<meta http-equiv=\"Refresh\" content=\"0; url='$username'\" />" >> index.html

