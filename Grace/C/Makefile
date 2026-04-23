NAME	=	Grace

SRC_DIR	=	srcs/
OBJ_DIR	=	dist/

SRCS	=	Grace.c
OBJS	=	$(SRCS:%.c=dist/%.o)

CC		=	clang
CFLAGS	=	-Wall -Werror -Wextra

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJS)

test: $(NAME)
	./$(NAME)
	diff Grace_kid.c $(SRC_DIR)$(SRCS)

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: re fclean clean all
