.ORIG x3000

; Инициализация
LD R2, INIT
LEA R1, ARRAY

; Ввод данных
INPUT_LOOP
ADD R2, R2, #1
LEA R0, INPUT_PROMPT
PUTS

GETC
OUT

ADD R3, R0, #0
LD R4, NEG_ASCII_ZERO ; Загрузка -48 в R4
ADD R3, R3, R4        ; Преобразование символа в число
STR R3, R1, #0
ADD R1, R1, #1

LEA R0, NEWLINE
PUTS

ADD R3, R2, #-10
BRz BUBBLE_SORT
BRnzp INPUT_LOOP

; Сортировка пузырьком
BUBBLE_SORT
LD R6, ARRAY_LEN     ; Загрузка длины массива в R6
ADD R4, R6, #0       ; Копируем длину массива в R4

OUTER_LOOP
ADD R4, R4, #-1      ; Уменьшаем R4 на 1
BRz OUTPUT_LOOP      ; Если R4 = 0, массив отсортирован
LEA R3, ARRAY        ; Указатель на начало массива
ADD R5, R4, #0       ; Копируем R4 в R5

INNER_LOOP
LDR R0, R3, #0       ; Загружаем текущий элемент
LDR R1, R3, #1       ; Загружаем следующий элемент
NOT R2, R1
ADD R2, R2, #1
ADD R2, R0, R2       ; R2 = R0 - R1
BRN SWAP             ; Если R0 > R1, меняем местами
SKIP_SWAP
ADD R3, R3, #1       ; Переходим к следующему элементу
ADD R5, R5, #-1      ; Уменьшаем счетчик
BRp INNER_LOOP
BRnzp OUTER_LOOP

SWAP
STR R1, R3, #0       ; Меняем элементы местами
STR R0, R3, #1
BRnzp SKIP_SWAP

; Вывод данных
OUTPUT_LOOP
LEA R1, ARRAY        ; Перезагрузка адреса начала массива
LD R2, INIT          ; Сброс счетчика элементов

PRINT_LOOP
LDR R0, R1, #0       ; Загрузка элемента массива в R0
LD R4, ASCII_ZERO
ADD R0, R0, R4       ; Преобразование числа обратно в символ ASCII
OUT                  ; Вывод символа
LEA R0, NEWLINE
PUTS                 ; Вывод новой строки
ADD R1, R1, #1       ; Переход к следующему элементу
ADD R2, R2, #1
ADD R3, R2, #-10
BRz END
BRnzp PRINT_LOOP

; Завершение программы
END
HALT

; Константы и данные
INIT .FILL #0
INPUT_PROMPT .STRINGZ "Enter a number: "
NEWLINE .STRINGZ "\n"
ASCII_ZERO .FILL #48
NEG_ASCII_ZERO .FILL #-48
ARRAY .BLKW #10
ARRAY_LEN .FILL #10

.END
