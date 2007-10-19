<?php

	//create an xml writer
	
    $xmlWriter = xmlwriter_open_memory();
    xmlwriter_set_indent_string($xmlWriter, "\t");
    xmlwriter_start_document($xmlWriter);
    xmlwriter_start_element ($xmlWriter,'filepaths');

	$VALID_FILE_TYPES = array(".mp3");

	//scan the current directory for valid file types
	if($directory = dir(getcwd())) {
    	traverseDirectory($directory, $xmlWriter, $VALID_FILE_TYPES);
        $directory->close();
    }
	
	//recursively scans a directory for mp3 files
	function traverseDirectory($directory, $xmlWriter, $VALID_FILE_TYPES) {
		$handle = $directory->handle;
		$path = $directory->path;
        while(($child = readdir($handle)) !== false) {
			$fqPath = $path . "/" . $child;
			if($child != '.' && $child != '..') {
				if(is_dir($fqPath)) {
				    if($childDirectory = dir($fqPath)) {
				    	traverseDirectory($childDirectory, $xmlWriter, $VALID_FILE_TYPES);
		  			 	$childDirectory->close();
				    }
			  	} else {
					$valid = false;
			  		$extension = substr($child, strrpos($child, "."));
			  		foreach($VALID_FILE_TYPES as $i) {
						if($extension == $i) {
							$valid = true;
						}
			  		}	
		  			if($valid == true) {
						addFilepath($fqPath, $xmlWriter);
					}
			  	}
			}
        }
	}
    
    //add a filepath as an element
    function addFilepath($filepath, $xmlWriter) {
	    xmlwriter_write_element($xmlWriter, 'filepath', $filepath);
    }
    xmlwriter_end_element ($xmlWriter);
    xmlwriter_end_document($xmlWriter);
    
    //print out the xml
    $xmlString = xmlwriter_output_memory($xmlWriter, true);
    echo $xmlString;
?>