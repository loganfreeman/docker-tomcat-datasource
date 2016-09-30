IFS=$'\n'
images=( $(docker images --format "{{.ID}} {{.CreatedAt}}") ) 
for image in $images
do 
  echo $image
done
