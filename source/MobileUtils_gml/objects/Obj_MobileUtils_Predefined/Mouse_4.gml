


if(!array_length(kind_array))
	exit

if(MobileUtils_Vibrate_Is_Available())
	MobileUtils_Vibrate_Predefined(kind_array[index])

index ++

if(index == array_length(kind_array))
	index = 0

text = $"Predefined: {index}"
