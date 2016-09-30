GUIDES=`pwd`/../neo4j-guides
URL=guides.neo4j.com/fundamentals

function create_guide {
   cd $1
   $GUIDES/run.sh $2 $3 +1 http://$URL -a guides=http://guides.neo4j.com/fundamentals

   s3cmd put -P $3 s3://$URL/
   mv $3 /tmp/
   if [ "$4" != "" ]; then
   echo "Images" $4
   echo s3cmd put -P $4 s3://$URL/img/
   s3cmd put -P $4 s3://$URL/img/
   fi
   cd -
}

create_guide guides basics.adoc basics.html 
create_guide guides advanced.adoc advanced.html
create_guide guides updates.adoc updates.html
create_guide guides import.adoc import.html
create_guide guides movies.adoc movies.html
create_guide "guides" guides.adoc index.html "img/*.png img/*.jpg"
