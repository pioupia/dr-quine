NAME	=	Colleen

SRC_DIR	=	srcs/
OBJ_DIR	=	dist/

SRCS	=	Calleen.zig
OBJS	=	$(SRCS:%.zig=dist/%.o)

CC		=	/tmp/tmp.Z9nXF55cja/zig-x86_64-linux-0.16.0/zig
CFLAGS	=	build-obj

$(OBJ_DIR)%.o: $(SRC_DIR)%.zig
	@mkdir -p $(OBJ_DIR)
	$(CC) build-obj $< -femit-bin=$@

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) build-exe -femit-bin=$(NAME) $(OBJS)

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
