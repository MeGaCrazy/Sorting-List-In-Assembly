# The Aim of project is making Sorting For List in Direction Selected By User
# Project Flow :
#         Getting List From User
#         Getting Sorting Direction 0 For ASC  1 For DSC
#         CAll Function Sort and making Sort  depend on "Bubble Sort" Technique
#         Print The Sorted List and Termind
.data
title_Msg:   .asciiz   "Enter the List 15 Elements:\n"
Choice_Msg:  .asciiz   "Choice Sort Order (0) Asc (1) Dsc :\n"
Sorting_Msg: .asciiz   "Process Sucess\nList is:"
finish_Msg:  .asciiz   "\nDone!!.."
Seperate_Msg: .asciiz  " "
List:    .word      0:15

.text

Main:
   # For Printint title Msg
   li $v0, 4
   la $a0, title_Msg
   syscall
    
##### Getting Array Elements #####
   li $t0, 0  #index of array
   li $t1,  60 # For Getting All 15 Elements [15 * 4 bit]
  
 while:
    beq $t0, $t1 , exit
        
    li $v0, 5           # Getting input
    syscall
        
    sw $v0 , List($t0)  # Store input element to Array
    addi $t0 , $t0, 4   # add 4 bit to Go for next Index in Array 
    j while             # Go to While
  exit:  
    ###### Getting Choice #########
     # For Print choice Msg
    li $v0, 4
    la $a0, Choice_Msg
    syscall
    
    # Getting Sort_Direction
    li $v0, 5    
    syscall
    move $s0, $v0
         
        
        
    jal Sort            # Call Procuder Sort 
    
    
    # Print Msg List After Sorting
     li $v0, 4
     la $a0, Sorting_Msg
     syscall
    ##### Print List After Sorting ####
      li $t0, 0  #index of array
      li $t1,  60 # For Getting All 15 Elements [15 * 4 bit]
      Loop:
       beq $t0, $t1 , Exitloop      # if index reach end of array go to ExitLoop
       lw $t4 , List($t0)           # load content of List and index $t0 to $t4
       
       # Print The Element
       li $v0, 1
       move $a0, $t4
       syscall       
       # Print Seperate_Space
       li $v0, 4
       la $a0, Seperate_Msg
        syscall
            
       addi $t0 , $t0, 4   # Go to next Element(Cur+1)
       j Loop              # Jump to Loop
                
  Exitloop:  
            
   # For Terminate The Proceduer
   li $v0, 4
   la $a0, finish_Msg
   syscall
    
   li $v0, 10
   syscall
    
Sort:
   li $t0, 0   # index of array
   li $t1,  14 # For iterate 14 iteration , Last Iteration Won't make anyChange For List
  LP1:
      beq $t0, $t1, Exit1
        li $t2, 0   # index of array
        li $t3,  56 # For iterate over all the array except the last one to avoid Memory OverFlow  
      LP2:
        beq $t2, $t3 , Exit2       # Exit if Reach LastElement-1
        
        lw $t4, List($t2)          # t4 store List[CurIndex]
        add $t6, $t2, 4            # t6 go for next index
        lw $t5 , List($t6)         # t5 store List[CurIndex+1]
        slt $t7, $t4 , $t5         # put 1 in t7 if t4 < t5
        bne $s0 , $zero, Descending
        # Here we compare Ascanding
            beq $t7, $zero, Swap   # If t4 > t5 then Swap to elements in the List
            add $t2 , $t2, 4       # Go to Next Element (Cur+1)
            j LP2
        # Here we compare Descending   
       Descending:
            bne $t7 , $zero , Swap # if t4 < t5 then Swap to elements in the List
            add $t2 , $t2, 4       # Go to Next Element (Cur+1)
            j LP2                  # Jump to LP2
                
       Swap:
         sw $t4, List($t6)         # put Content Of List[Cur] in List[Cur+1] 
         sw $t5 , List($t2)        # put Content Of List[Cur+1] in List[Cur] 
         add $t2, $t2, 4           # Go to Next Element (Cur+1)
         j LP2
      Exit2:        
       add $t0, $t0, 1             # Go to Next iteration in LP 1 (Cur+1)
       j LP1                       # Jump To LP 1
         
  Exit1:  
        jr $ra                     # Return the function


