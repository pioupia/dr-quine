NAME	=	Colleen

SRC_DIR	=	srcs/
OBJ_DIR	=	dist/

SRCS	=	main.s
OBJS	=	$(SRCS:%.s=$(OBJ_DIR)%.o)

NASM	=	nasm
NFLAGS	=	-g -f elf64
CFLAGS	=	-Wall -Werror -Wextra

$(OBJ_DIR)%.o: $(SRC_DIR)%.s
	@mkdir -p $(OBJ_DIR)
	$(NASM) $(NFLAGS) $< -o $@

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJS)

test: $(NAME)
	./$(NAME) > output
	diff output $(SRC_DIR)main.s
	rm output

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: re fclean clean all
