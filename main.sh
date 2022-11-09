#!/bin/bash

#######-------Colours-------######
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

logo() {
    echo -e "$GREEN
                                         
 ██████  ██████  ███    ███ ███████     ██ ████████ ██ 
 ██   ██ ██   ██ ████  ████ ██          ██    ██    ██  
 ██   ██ ██████  ██ ████ ██ ███████     ██    ██    ██ 
 ██   ██ ██   ██ ██  ██  ██      ██     ██    ██    ██  
 ██████  ██████  ██      ██ ███████     ██    ██    ██ 
 Welcome to DBMS Software. 
$NC"
}
#################################################################
#################################################################
updatetable() {
    dbdir="./.dbms/$CDB"
    read -p $'\n'"Enter table name: " tableename
    echo ""
    if [ -f "$dbdir/$tableename" ]; then
        columnlist=($(cut -f1 -d: "${dbdir}/.${tableename}_meta"))
        columnlist+=("Back")
        ((columnlength = ${#columnlist[@]}))
        for ((i = 0; i < ${#columnlist[@]}; i++)); do
            ((int = $i + 1))
            back="Back"
            if [[ "${columnlist[$i]}" == "$back" ]]; then
                echo -e "${GREEN}${int}) ${columnlist[$i]} ${NC}"
            else
                echo -e "${int}) ${columnlist[$i]}"
            fi
        done
        while true; do
            read -p $'\n'"Enter column no to be updated: " column
            if ([[ $columnlength -gt $column || $columnlength = $column ]] && [[ $column -ne 0 ]]); then
                if [ $column -eq $columnlength ]; then
                    connect
                else
                    ((ncolumn = column - 1))
                    #  read -p $'\n'"Enter your new value of [${columnlist[$ncolumn]}]: " new_value

                    chkDT=$(awk -F":" -v d=$column '(NR==d){print $2}' "${dbdir}/.${tableename}_meta")
                    chkPK=$(awk -F":" -v d=$column '(NR==d){print $3}' "${dbdir}/.${tableename}_meta")
                    if ([[ "$chkDT" == "STRING" ]] && [[ "$chkPK" == "NULL" ]]); then

                        while true; do
                            read -p $'\n'"Enter New Value (must be string): " value
                            if [[ "${value}" =~ ^[a-zA-Z]+$ ]]; then

                                while true; do
                                    read -p $'\n'"Enter Primary Key value: " PK
                                    chPKDT=$(awk -F":" '$3 ~ /PK/ {print $2}' "${dbdir}/.${tableename}_meta")
                                    case $chPKDT in
                                    "INTEGER")
                                        if [[ "${PK}" =~ ^[0-9]+$ ]]; then
                                            pk_no=$(cut -f3 -d: "${dbdir}/.${tableename}_meta" | grep -nw PK | cut -f1 -d:)
                                            awk -i inplace -F ':' -v k=${column} -v p=$pk_no -v cp=${PK} -v nk="${value}" 'BEGIN { OFS=":"};{if($p==cp) $k=nk; print $0}' "${dbdir}/${tableename}"
                                            break 2
                                        else
                                            echo -e "\n${RED}Column must be INTEGER.${NC}"
                                        fi
                                        ;;
                                    "STRING")

                                        if [[ "${PK}" =~ ^[a-zA-Z]+$ ]]; then
                                            pk_no=$(cut -f3 -d: "${dbdir}/.${tableename}_meta" | grep -nw PK | cut -f1 -d:)
                                            awk -i inplace -F ':' -v k=${column} -v p=$pk_no -v cp=${PK} -v nk="${value}" 'BEGIN { OFS=":"};{if($p==cp) $k=nk; print $0}' "${dbdir}/${tableename}"
                                            break 2
                                        else
                                            echo -e "\n${RED}Column must be STRING.${NC}"
                                        fi

                                        ;;
                                    esac
                                done

                            else
                                echo -e "\n${RED}Column must be String.${NC}"

                            fi
                        done
                        echo -e "\nUpdating...\n"
                        sleep 0.4
                        echo -e "-----------------------------------------------"
                        echo -e "\n${GREEN}Data updated successfully.${NC}.\n"
                        echo -e "-----------------------------------------------"
                        break 2
                    elif
                        ([[ "$chkDT" == "INTEGER" ]] && [[ "$chkPK" == "NULL" ]])
                    then

                        while true; do
                            read -p $'\n'"Enter New Value (INTEGER): " value
                            if [[ "${value}" =~ ^[0-9]+$ ]]; then

                                while true; do
                                    read -p $'\n'"Enter Primary Key value: " PK
                                    chPKDT=$(awk -F":" '$3 ~ /PK/ {print $2}' "${dbdir}/.${tableename}_meta")
                                    case $chPKDT in
                                    "INTEGER")
                                        if [[ "${PK}" =~ ^[0-9]+$ ]]; then
                                            pk_no=$(cut -f3 -d: "${dbdir}/.${tableename}_meta" | grep -nw PK | cut -f1 -d:)
                                            awk -i inplace -F ':' -v k=${column} -v p=$pk_no -v cp=${PK} -v nk="${value}" 'BEGIN { OFS=":"};{if($p==cp) $k=nk; print $0}' "${dbdir}/${tableename}"
                                            break 2
                                        else
                                            echo -e "\n${RED}Column must be INTEGER.${NC}"
                                        fi
                                        ;;
                                    "STRING")

                                        if [[ "${PK}" =~ ^[a-zA-Z]+$ ]]; then
                                            pk_no=$(cut -f3 -d: "${dbdir}/.${tableename}_meta" | grep -nw PK | cut -f1 -d:)
                                            awk -i inplace -F ':' -v k=${column} -v p=$pk_no -v cp=${PK} -v nk="${value}" 'BEGIN { OFS=":"};{if($p==cp) $k=nk; print $0}' "${dbdir}/${tableename}"
                                            break 2
                                        else
                                            echo -e "\n${RED}Column must be STRING.${NC}"
                                        fi

                                        ;;
                                    esac
                                done

                            else
                                echo -e "\n${RED}Column must be String.${NC}"

                            fi
                        done
                        echo -e "\nUpdating...\n"
                        sleep 0.4
                        echo -e "-----------------------------------------------"
                        echo -e "\n${GREEN}Data updated successfully.${NC}.\n"
                        echo -e "-----------------------------------------------"
                        break 2
                    elif

                        ([[ "$chkDT" == "STRING" ]] && [[ "$chkPK" == "PK" ]])
                    then

                        while true; do
                            read -p $'\n'"Enter New Value (must be string): " value
                            if [[ "${value}" =~ ^[a-zA-Z]+$ ]]; then

                                while true; do
                                    read -p $'\n'"Enter Primary Key value: " PK
                                    chPKDT=$(awk -F":" '$3 ~ /PK/ {print $2}' "${dbdir}/.${tableename}_meta")
                                    case $chPKDT in
                                    "INTEGER")
                                        if [[ "${PK}" =~ ^[0-9]+$ ]]; then
                                            pk_no=$(cut -f3 -d: "${dbdir}/.${tableename}_meta" | grep -nw PK | cut -f1 -d:)
                                            awk -i inplace -F ':' -v k=${column} -v p=$pk_no -v cp=${PK} -v nk="${value}" 'BEGIN { OFS=":"};{if($p==cp) $k=nk; print $0}' "${dbdir}/${tableename}"
                                            break 2
                                        else
                                            echo -e "\n${RED}Column must be INTEGER.${NC}"
                                        fi
                                        ;;
                                    "STRING")

                                        if [[ "${PK}" =~ ^[a-zA-Z]+$ ]]; then
                                            pk_no=$(cut -f3 -d: "${dbdir}/.${tableename}_meta" | grep -nw PK | cut -f1 -d:)
                                            awk -i inplace -F ':' -v k=${column} -v p=$pk_no -v cp=${PK} -v nk="${value}" 'BEGIN { OFS=":"};{if($p==cp) $k=nk; print $0}' "${dbdir}/${tableename}"
                                            break 2
                                        else
                                            echo -e "\n${RED}Column must be STRING.${NC}"
                                        fi

                                        ;;
                                    esac
                                done

                            else
                                echo -e "\n${RED}Column must be String.${NC}"

                            fi
                        done
                        echo -e "\nUpdating...\n"
                        sleep 0.4
                        echo -e "-----------------------------------------------"
                        echo -e "\n${GREEN}Data updated successfully.${NC}.\n"
                        echo -e "-----------------------------------------------"
                        break 2

                    elif

                        ([[ "$chkDT" == "INTEGER" ]] && [[ "$chkPK" == "PK" ]])
                    then

                        while true; do
                            read -p $'\n'"Enter New Value (INTEGER): " value
                            if [[ "${value}" =~ ^[0-9]+$ ]]; then

                                while true; do
                                    read -p $'\n'"Enter Primary Key value: " PK
                                    chPKDT=$(awk -F":" '$3 ~ /PK/ {print $2}' "${dbdir}/.${tableename}_meta")
                                    case $chPKDT in
                                    "INTEGER")
                                        if [[ "${PK}" =~ ^[0-9]+$ ]]; then
                                            pk_no=$(cut -f3 -d: "${dbdir}/.${tableename}_meta" | grep -nw PK | cut -f1 -d:)
                                            awk -i inplace -F ':' -v k=${column} -v p=$pk_no -v cp=${PK} -v nk="${value}" 'BEGIN { OFS=":"};{if($p==cp) $k=nk; print $0}' "${dbdir}/${tableename}"
                                            break 2
                                        else
                                            echo -e "\n${RED}Column must be INTEGER.${NC}"
                                        fi
                                        ;;
                                    "STRING")

                                        if [[ "${PK}" =~ ^[a-zA-Z]+$ ]]; then
                                            pk_no=$(cut -f3 -d: "${dbdir}/.${tableename}_meta" | grep -nw PK | cut -f1 -d:)
                                            awk -i inplace -F ':' -v k=${column} -v p=$pk_no -v cp=${PK} -v nk="${value}" 'BEGIN { OFS=":"};{if($p==cp) $k=nk; print $0}' "${dbdir}/${tableename}"
                                            break 2
                                        else
                                            echo -e "\n${RED}Column must be STRING.${NC}"
                                        fi

                                        ;;
                                    esac
                                done

                            else
                                echo -e "\n${RED}Column must be String.${NC}"

                            fi
                            break
                        done
                        echo -e "\nUpdating...\n"
                        sleep 0.4
                        echo -e "-----------------------------------------------"
                        echo -e "\n${GREEN}Data updated successfully.${NC}.\n"
                        echo -e "-----------------------------------------------"
                        break 2
                    else

                        echo -e "\nSomthing went wrong."
                        break 2
                    fi

                fi

            else

                echo -e "\n${RED}Wrong entry.${NC}\n"
            fi
        done

    else

        echo -e "\n${RED}${tableename} not exists.${NC}\n"
        sleep 0.5
        connect
    fi

}

#################################################################
#################################################################

deletefromtable() {
    # set -x
    dbdir="./.dbms/$CDB"
    while true; do
        read -p $'\n'"Enter table name: " tableename

        if [ -f "$dbdir/$tableename" ]; then
            columnlist=($(cut -f1 -d: "${dbdir}/${tableename}"))

            for ((i = 0; i < ${#columnlist[@]}; i++)); do
                ((r = $i + 1))
                records=$(sed -n ${r}p $dbdir/$tableename)
                echo ""
                echo -e "${r}) $records"
                r=0
            done
            noOfRow=$(wc -l $dbdir/$tableename | cut -f1 -d" ")
            while true; do
                read -p $'\n'"Select no of row: " row_no
                if [[ $row_no < $noOfRow || $row_no = $noOfRow ]] && [[ $row_no =~ ^[0-9]+$ ]]; then
                    gawk -i inplace -v n=$row_no 'NR == n {next} {print}' "$dbdir/$tableename"
                    echo ""
                    echo "---------------------------------------------------"
                    echo -e "${GREEN}Row deleted successfuly.${NC}"
                    echo "---------------------------------------------------"
                    break 2
                else
                    echo -e "\n${RED}Wrong entry, try again.${NC}"
                fi
            done
        else
            echo -e "\n${RED}${tableename} not exists.${NC}\n"
        fi
        # echo ${columnarr[@]}
    done
    # set +x
}

#################################################################
#################################################################
selectfromtable() {
    dbdir="./.dbms/$CDB"
    read -p $'\n'"Enter table name: " tableename
    echo ""
    if [ -f "$dbdir/$tableename" ]; then
        columnlist=($(cut -f1 -d: "${dbdir}/.${tableename}_meta"))
        columnlist+=("Back")
        ((columnlength = ${#columnlist[@]}))
        for ((i = 0; i < ${#columnlist[@]}; i++)); do
            ((int = $i + 1))
            back="Back"
            if [[ "${columnlist[$i]}" == "$back" ]]; then
                echo -e "${GREEN}${int}) ${columnlist[$i]} ${NC}"
            else
                echo -e "${int}) ${columnlist[$i]}"
            fi
        done
        read -p $'\n'"Enter column no to select with: " column
        if ([[ $columnlength -gt $column || $columnlength = $column ]] && [[ $column -ne 0 ]]); then
            if [ $column -eq $columnlength ]; then
                connect
            else
                ((column = $column - 1))
                echo "----------------------------------------------------"
                echo -e "${GREEN}Column [${columnlist[$column]}]:${NC}"
                echo "----------------------------------------------------"
                ((column = $column + 1))
                c="$(cut -f$column -d: "$dbdir/$tableename")"
                echo -e "$c"
                echo "----------------------------------------------------"
                read -p "Enter name of field: " field
                unset 'columnlist[${#columnlist[@]}-1]'
                g=$(awk -F ':' -v f=$field -v x=$column 'BEGIN { OFS=" "};{if($x==f) print $0}' $dbdir/$tableename)
                echo -e "\n"
                echo "----------------------------------------------------"
                echo -e "\n${GREEN}${columnlist[@]}${NC}" | column -t -s $' '
                echo "----------------------------------------------------"
                echo -e "$g\n" | column -t -s $':'
                echo "----------------------------------------------------"
                if [[ $g == "" ]]; then
                    echo -e "${RED}Sorry no record with field [${field}].${NC}"
                else
                    :
                fi
            fi
        else
            echo -e "\n${GREEN}Available Records: ${NC}"
            echo -e "\n${RED}Somthing wrong.${NC}\n"
        fi
    else
        echo -e "\n${RED}${tableename} not exists.${NC}\n"
        sleep 0.5
        connect
    fi
}

#################################################################
#################################################################
insert() {

    dbdir="./.dbms/$CDB"
    read -p $'\n'"Enter table name: " tablename
    if [ -f "$dbdir/$tablename" ]; then

        table_lines=$(wc -l "${dbdir}/.${tablename}_meta" | cut -f1 -d" ")
        ((i = 0))
        while ((i < $table_lines)); do
            ((i += 1))
            checkdatatype=$(awk -F":" -v i=$i '(NR==i){print $2}' "${dbdir}/.${tablename}_meta")
            checkkeytype=$(awk -F":" -v i=$i '(NR==i){print $3}' "${dbdir}/.${tablename}_meta")
            if ([[ "$checkdatatype" == "STRING" ]] && [[ "$checkkeytype" == "NULL" ]]); then

                while true; do
                    read -p $'\n'"${i}) Enter value (STRING & NOT PK): " value
                    if [[ "${value}" =~ ^[a-zA-Z]+$ ]]; then
                        data+=("$value")
                        break
                    else
                        echo -e "\n${RED}Column must be String.${NC}"

                    fi
                done

            elif
                ([[ "$checkdatatype" == "INTEGER" ]] && [[ "$checkkeytype" == "NULL" ]])
            then
                while true; do
                    read -p $'\n'"${i}) Enter value (INT & NOT PK): " value
                    if [[ "${value}" =~ ^[0-9]+$ ]]; then
                        data+=("$value")
                        break
                    else
                        echo -e "\n${RED}Column must be Integer.${NC}"

                    fi
                done

            elif
                ([[ "$checkdatatype" == "STRING" ]] && [[ "$checkkeytype" == "PK" ]])
            then

                while true; do
                    read -p $'\n'"${i}) Enter value (STRING & PK): " value
                    if [[ "${value}" =~ ^[a-zA-Z]+$ ]]; then
                        e=$(cut -f$i -d: $dbdir/$tablename | grep -w $value)
                        if [[ "$e" != "$value" ]]; then
                            data+=("$value")
                            break
                        else
                            echo -e "\n${RED}Column must be unique.${NC}"
                        fi
                    else
                        echo -e "\n${RED}Column must be String.${NC}"

                    fi
                done

            elif
                ([[ "$checkdatatype" == "INTEGER" ]] && [[ "$checkkeytype" == "PK" ]])
            then

                while true; do
                    read -p $'\n'"${i}) Enter value (INT & PK): " value
                    if [[ "${value}" =~ ^[0-9]+$ ]]; then
                        e=$(cut -f$i -d: $dbdir/$tablename | grep -w $value)
                        if [[ "$e" != "$value" ]]; then
                            data+=("$value")
                            break
                        else
                            echo -e "\n${RED}Column must be unique.${NC}"
                        fi
                    else
                        echo -e "\n${RED}Column must be Integer.${NC}"

                    fi
                done

            else

                echo -e "\nSomthing went wrong."
                break
            fi

        done
        var=$(printf '%s:' "${data[@]}")
        # echo -e "${var%:}"
        echo -e "${var%:}" >>"$dbdir/$tablename"
        data=()
        echo -e "\nInserting...\n"
        sleep 0.4
        echo -e "-----------------------------------------------"
        echo -e "\n${GREEN}Data created successfully.${NC}.\n"
        echo -e "-----------------------------------------------"
    else
        echo "$tablename not exists."
    fi

}

#################################################################
#################################################################
droptable() {
    options=($(ls ./.dbms/$CDB))
    clear
    logo
    options+=("Main menu")
    ((arr_length = ${#options[@]}))
    echo ""
    for ((i = 0; i < ${#options[@]}; i++)); do
        ((int = $i + 1))
        main="Main menu"
        if [[ "${options[$i]}" == "$main" ]]; then
            echo -e "${RED}${int}) ${options[$i]} ${NC}"
        else
            echo -e "$int) ${options[$i]}"
        fi
    done
    echo ""
    read -p "Select Table to Drop: " drop
    if ([[ $arr_length -gt $drop || $arr_length = $drop ]] && [[ $drop -ne 0 ]]); then
        if [ $drop -eq $arr_length ]; then
            mainmenu
        else
            read -p "Are you sure [Y/N]: " y_n

            if [[ "$y_n" == [Yy] ]]; then
                ((drop = $drop - 1))
                drop_ind=${options[$drop]}
                rm -rf ./.dbms/$CDB/$drop_ind
                rm -rf "./dbms/$CDB/${drop_ind}_meta" >>/dev/null
                echo -e "$RED\nDroped\n$NC"
                sleep 1
            elif [[ "$y_n" == [Nn] ]]; then
                connect
            else
                echo -e "$RED\nWrong choice$NC\n"
                sleep 1.5
                dropdatabase
            fi
        fi
    else
        echo -e "$RED\nWrong choice$NC\n"
        sleep 1.5
        dropdatabase
    fi

}

#################################################################
#################################################################
createtable() {

    dbdir="./.dbms/$CDB"

    while true; do
        read -p $'\n'"Enter table name: " table_name
        # table_exist=$(find $dbdir -type f -name "{$table_name}" | grep -i "$table_name") 2> /dev/null
        if [ -d $dbdir ]; then
            if [ -f $dbdir/$table_name ]; then
                echo -e "\n${RED}${table_name} table already exists.${NC}\n"
            elif [ -z "$table_name" ]; then
                echo -e "\n${RED} empty response ! please enter something.${NC}\n"

            elif [[ $table_name == *" "* ]] || [[ $table_name == [0-9]* ]] || [[ $table_name == *['!'';''.'@\#\$%^\&*()+-='\'?'/''`'~:,'<''>''['']']* ]]; then
                echo -e "\n${RED} name entered is not in accepted format.${NC}\n"
            else
                touch ${dbdir}/${table_name} 2>/dev/null
                if [ -f $dbdir/$table_name ]; then
                    touch ${dbdir}/.${table_name}_meta 2>/dev/null
                #touch ${dbdir}/${table_name}_meta 2> /dev/null
                fi
                if [ -f $dbdir/$table_name ] && [ -f ${dbdir}/.${table_name}_meta ]; then
                    echo -e "\n${GREEN} ${table_name} accepted.${NC}\n"
                    echo -e "\nEnter to continue.." && read
                    break
                else
                    echo -e "\n${RED}name entered is not accepted table cannot be created.${NC}\n"
                fi

            fi
        else
            echo -e "\n${RED}Your .dbms or ${CDB} directories have been removed or destroyed, please check those directories and try again.${NC}\n"
        fi

    done
    createtable_columns $table_name
    #connect
}

#################################################################
#################################################################
namechecker() {

    if [ -z $1 ]; then
        echo -e "\n${RED} empty response ! please enter something.${NC}\n"
        break_flag=0

    elif [[ $1 == *" "* ]] || [[ $1 == [0-9]* ]] || [[ $1 == *['!'';''.'@\#\$%^\&*()+-='\'?'/''`'~:,'<''>''['']']* ]]; then
        echo -e "\n${RED} name entered is not in accepted format.${NC}\n"
        break_flag=0
    else
        echo -e "\n${RED}${1} is accepted.${NC}\n"
        echo -e "\nEnter to continue..." && read
        break_flag=1
    fi

}

#################################################################
#################################################################
createtable_columns() {

    dbdir="./.dbms/$CDB"
    table_meta=.$1_meta
    column_names=()
    while true; do
        read -p "Enter the number of columns:" col_num
        if ! [[ "$col_num" =~ ^[0-9]+$ ]]; then
            echo -e "\n${RED} Column number must be positive integer number .${NC}\n"
        elif [[ $col_num -eq 0 ]]; then
            echo -e "\n${RED} enter at least 1 column .${NC}\n"
        else
            columns_length=$col_num
            break
        fi
    done
    k=1
    while (($k <= $col_num)); do
        while true; do

            while true; do
                read -p $'\n'"Enter the Column No.$k Name:" column_name
                column_found=$(cut -f1 -d: $dbdir/$table_meta | grep "${column_name}")
                if [ "$column_found" = "$column_name" ]; then
                    echo -e "\n${RED} this name is used already .${NC}\n"
                    continue
                fi
                namechecker $column_name
                if [ $break_flag = 1 ]; then
                    break
                fi
            done

            cl_datatype=" "
            datatype_choice
            echo -n $column_name >>${dbdir}/${table_meta}
            echo -n ":" >>${dbdir}/${table_meta}
            echo -n $cl_datatype >>${dbdir}/${table_meta}
            echo "" >>${dbdir}/${table_meta}
            k=$(($k + 1))
            break
        done
    done
    pmkey_column=" "
    until [[ $choice == 1 ]] || [[ $choice == 2 ]]; do
        echo -e "\n do you like to insert a primary key ?\n"
        read -p "Choose data type  (1)for YES (2)for NO:" choice

    done
    if [[ $choice == 1 ]]; then
        column_names=$(cut -f1 -d: ${dbdir}/${table_meta})
        sleep 1
        column_ch_found="a"
        column_ch="b"
        while [[ "$column_ch_found" != "$column_ch" ]]; do
            echo $column_names
            read -p "enter a column name out of the above names to choose this column as primarykey : " column_ch

            column_ch_found=$(cut -f1 -d: ${dbdir}/${table_meta} | grep ${column_ch})
        done
        pmkey_column="$column_ch"
        echo $pmkey_column
        #awk -F ':' 'BEGIN { OFS=":"};{if($1)$2=$2":NULL";print $0}' ${dbdir}/${table_meta}
        #awk  '$2 = $2 ":" "NULL"' ${dbdir}/${table_meta}
        gawk -i inplace 'BEGIN{FS=OFS=":"}{print $0 OFS "NULL"}' ${dbdir}/${table_meta}
        gawk -i inplace -F ':' -v x=$pmkey_column 'BEGIN { OFS=":"};{if($1==x)$3="PK";print $0}' ${dbdir}/${table_meta}
        echo -e "\n${GREEN} creating.....${NC}\n"
        sleep 1
    else
        echo -e "\n primary key will not be inserted.\n"
        sleep 0.5
    fi
    connect
}

#################################################################
#################################################################
namechecker() {

    if [ -z $1 ]; then
        echo -e "\n${RED} empty response ! please enter something.${NC}\n"
        break_flag=0

    elif [[ $1 == *" "* ]] || [[ $1 == [0-9]* ]] || [[ $1 == *['!'';''.'@\#\$%^\&*()+-='\'?'/''`'~:,'<''>''['']']* ]]; then
        echo -e "\n${RED} name entered is not in accepted format.${NC}\n"
        break_flag=0
    else
        echo -e "\n${RED}${1} is accepted.${NC}\n"
        echo -e "\nEnter to continue..." && read
        break_flag=1
    fi

}

#################################################################
#################################################################
datatype_choice() {
    local choice='0'
    until [[ $choice == 1 ]] || [[ $choice == 2 ]]; do
        echo Datatype must be INTEGER or STRING
        read -p "Choose data type  (1)for INTEGER (2)for STRING:" choice

    done
    if [[ $choice == 1 ]]; then
        cl_datatype="INTEGER"
    else
        cl_datatype="STRING"
    fi
}
#################################################################
#################################################################
dbname() {
    clear
    logo

    while true; do
        read -p $'\033[0;31m Note: Database name not include characters,spaces and numbers.\033[0m.
 Please Enter your database name: ' db_name
        if [ -d ./.dbms/$db_name ]; then
            echo -e "$RED\n$db_name is already exists.\n$NC"
        elif ([[ $db_name =~ ^[a-z]+$ ]]); then
            if [ -z "$db_name" ]; then
                echo "wrong"
            else
                mkdir ./.dbms/$db_name
                echo -e " \n$RED $db_name database is created successfuly.\033[0m\n"
                break
            fi

        else
            echo -e " \n$RED Wrong database name.\n Please follow the above instruction for database name.\n$NC"

        fi
    done
    submenu
}

#################################################################
#################################################################
creatdb() {
    clear
    logo
    dbmsdir=./.dbms
    if [ -d $dbmsdir ]; then
        dbname
    else
        mkdir $dbmsdir
        echo -e "\n$RED .dbms folder create under your current working dir.$NC\n"
        dbname
    fi
}

#################################################################
#################################################################
submenu() {
    PS3="
Select your entry please: "
    options=("Main menu" "Exit")
    select number in "${options[@]}"; do
        case $REPLY in
        "1")
            mainmenu
            ;;
        "2")
            exit
            ;;
        *)
            echo -e "$RED\nInvalid option $REPLY $NC\n"
            submenu
            ;;
        esac
    done
}

#################################################################
#################################################################
dropdatabase() {
    options=($(ls ./.dbms/))
    clear
    logo
    options+=("Main menu")
    ((arr_length = ${#options[@]}))
    #echo $arr_length
    echo ""
    for ((i = 0; i < ${#options[@]}; i++)); do
        ((int = $i + 1))
        main="Main menu"
        if [[ "${options[$i]}" == "$main" ]]; then
            echo -e "${RED}${int}) ${options[$i]} ${NC}"
        else
            echo -e "$int) ${options[$i]}"
        fi
    done
    echo ""
    read -p "Select Database to Drop: " drop
    if ([[ $arr_length -gt $drop || $arr_length = $drop ]] && [[ $drop -ne 0 ]]); then
        if [ $drop -eq $arr_length ]; then
            mainmenu
        else
            read -p "Are you sure [Y/N]: " y_n

            if [[ "$y_n" == [Yy] ]]; then
                ((drop = $drop - 1))
                drop_ind=${options[$drop]}
                rm -rf ./.dbms/$drop_ind
                echo -e "$RED\nDroped\n$NC"
                sleep 1
            elif [[ "$y_n" == [Nn] ]]; then
                mainmenu
            else
                echo -e "$RED\nWrong choice$NC\n"
                sleep 1.5
                dropdatabase
            fi
        fi
    else
        echo -e "$RED\nWrong choice$NC\n"
        sleep 1.5
        dropdatabase
    fi

}

#################################################################
#################################################################
connect() {

    PS3=$(echo -e "$GREEN\nSelect your entry please: ${NC}")
    echo ""
    clear
    logo
    echo -e "${GREEN}Connected to [${CDB}] Database.${NC}"
    echo -e "${GREEN}tables:${NC}${RED}\n$(ls ./.dbms/${CDB}/)${NC}\n"
    #######-Main menu selection-######
    menu=("Create table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back" "Exit")

    select number in "${menu[@]}"; do #select number in "Mohamed" "Alaa"
        case $REPLY in
        1)
            createtable
            ;;
        2)
            echo -e "\n" && ls -I *_meta ./.dbms/$CDB
            echo -e "\nEnter to main menu..." && read
            clear
            logo
            ;;
        3)
            droptable
            ;;
        4)
            insert
            ;;

        5)
            selectfromtable
            ;;
        6)
            deletefromtable
            ;;

        7)
            updatetable
            ;;
        8)
            enterDB
            ;;
        9)
            echo -e "\n${RED}Bye $NC\n"
            exit
            ;;
        *)
            echo -e "$RED\nNo right entry.$NC"
            ;;
        esac
    done
}

#################################################################
#################################################################
enterDB() {
    options=($(ls ./.dbms/))
    clear
    logo
    options+=("Main menu")
    ((arr_length = ${#options[@]}))
    echo ""
    for ((i = 0; i < ${#options[@]}; i++)); do
        ((int = $i + 1))
        main="Main menu"
        if [[ "${options[$i]}" == "$main" ]]; then
            echo -e "${RED}${int}) ${options[$i]} ${NC}"
        else
            echo -e "$int) ${options[$i]}"
        fi
    done
    echo ""

    read -p "Select Database to connect: " drop

    if ([[ $arr_length -gt $drop || $arr_length = $drop ]] && [[ $drop -ne 0 ]]); then
        :
        if [ $drop -eq $arr_length ]; then
            :
            mainmenu
        else
            export CDB="${options[(($drop - 1))]}"
            echo -e "$RED\nConnecting to ${options[(($drop - 1))]} ... $NC\n"
            sleep 0.5
            connect
        fi
    else
        :
    fi

}

#################################################################
#################################################################
mainmenu() {
    PS3="
Select your entry please: "
    clear
    logo
    menu=("Create Database" "List Databases" "Connect to Databases" "Drop Database" "Quit")

    select number in "${menu[@]}"; do #select number in "Mohamed" "Alaa"
        case $REPLY in
        1)
            creatdb
            ;;
        2)
            echo -e "\n" && ls ./.dbms/
            echo -e "\nEnter to main menu..." && read
            clear
            logo
            ;;
        3)
            enterDB
            ;;
        4)
            dropdatabase
            mainmenu
            ;;
        5)
            echo -e "\n${RED}Bye $NC\n"
            exit
            ;;
        *)
            echo -e "$RED\nNo right entry.$NC"
            ;;
        esac
    done
}

#################################################################
#################################################################
ind() {
    count=0
    total=34
    pstr=$(echo -e "${GREEN}[=======================================================================]$NC")
    while [ $count -lt $total ]; do
        sleep 0.009 # this is work
        count=$(($count + 1))
        pd=$(($count * 73 / $total))
        printf "\r%3d.%1d%% %.${pd}s" $(($count * 100 / $total)) $((($count * 1000 / $total) % 10)) $pstr
    done
}
#################################################################
#################################################################
ind
logo
mainmenu
