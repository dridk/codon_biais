BEGIN{
	current_name = ""
}

{
	name = $1
	if ( (length(current_name)==0) || (name != current_name))
	{
		current_name = name
		print("\n>",name)
	}

	printf "%s", $2

}

END {
	print "\n"
}