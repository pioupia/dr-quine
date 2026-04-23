NAME	=	Colleen

SRC_DIR	=	srcs/
OBJ_DIR	=	dist/

SRCS	=	Calleen.c
OBJS	=	$(SRCS:%.c=dist/%.o)

CC		=	cc
CFLAGS	=	-Wall -Werror -Wextra

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJS)

test: $(NAME)
	./$(NAME) > output
	diff output $(SRC_DIR)$(SRCS)
	rm output

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: re fclean clean all
