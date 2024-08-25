#! /bin/bash

echo -n "Hi! Do you want to play a game? [y/n] "
read -n 1 choose
echo ""

while [ "$choose" != "n" ] && [ "$choose" != "y" ]
do
	echo -n "Sorry. Please re-enter your choice [y/n]: "
	read -n1 choose
	echo ""
done

if [ "$choose" == "n" ]
then
	echo "Thank you. Bye!"
	exit
else
	touch leaderboard.txt
	echo -n "Good! what is your name? "
	read name
	if [ "$name" == "albert" ]
	then
		echo -e "\nGreetings, albert!"
		echo -n "Do you want to clear the leaderboard? [y/n] "
		read -sn 1  clearboard_choice
		while [ "$clearboard_choice" != "y" ] && [ "$clearboard_choice" != "n" ]
		do
			read -sn 1 clearboard_choice
		done
		echo ""
		if [ "$clearboard_choice" == "y" ]
		then
			> leaderboard.txt
			echo "Leaderboard is now cleared."
		fi
	fi

	echo ""
	echo "Welcome! $name!"
	echo "I am going to generate a number between 1-100."
	echo "You can try to guess it."
	echo "Once you input your number, I will tell you whether it is greater than or less than my number."
	echo -n "If you guess the number correctly, you win! Ready? [y/n] "
	read -n 1 choice
	echo ""
	while [ "$choice" != "y" ]
	do
		if [ "$choice" == n ]
		then
			sleep 5
			echo -n "Are you ready now? [y/n] "
		else
			echo -n "Sorry. Please re-enter your choice [y/n]: "
		fi
		read -n 1 choice
		echo ""
	done

	num=$(( (RANDOM % 100) + 1 ))
	upper=100
	lower=1
	guess=101
	counter=0
	echo ""
	echo -n "Good. Please take a guess: "

	while [ "$guess" -ne "$num" ]
	do
		read guess_str
		while ! [[ "$guess_str" =~ ^[0-9]+$ ]]
		do
			echo -n "Sorry that is not a positive interger. Please re-enter: "
			read guess_str
		done
		guess="$guess_str"	
		counter=$(( counter + 1 ))
		
		if [ "$guess" == 42 ]
		then
			echo ""
			echo "*******************"
			echo "- The answer to the ultimate question of life, the universe, and everything is: 42"
			echo "- Douglas Adams, The Hitchhiker's Guide to the Galaxy"
			echo "******************"
			echo ""
		fi
		
		if [ "$guess" -gt "$num" ]
		then
			if [ "$guess" -le "$upper" ]
			then
				upper="$guess"
			fi
			echo -n "Your number is greater than mine. Please take another guess [$lower-$upper]: "
		elif [ "$guess" -lt "$num" ]
		then
			if [ "$guess" -ge "$lower" ]
			then
				lower="$guess"
			fi
			echo -n "Your number is less than mine. Pleae take another guess [$lower-$upper]: "
		fi
	done
	if [ "$counter" == 1 ]
	then
		echo "Amazing! First guess! You win!"
	else
		echo "You win! You guessed correctly in $counter times!"
	fi

	echo -e "$name\t$counter\ttime(s)" >> leaderboard.txt
	sort -t$'\t' -k2,2 leaderboard.txt -o leaderboard.txt
	echo ""
	echo -n "Would you like to see the leaderboard? [y/n] "
	read -n 1 ldb_choice
	while [ "$ldb_choice" != "n" ] && [ "$ldb_choice" != "y" ]
	do
		read -s -n 1 ldb_choice
	done
	echo ""
	if [ "$ldb_choice" == "y" ]
	then
		cat leaderboard.txt | head -5
	fi


	echo -e "\nGood game. See you next time!"
fi