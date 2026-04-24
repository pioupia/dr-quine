NAME	=	Colleen

SRC_DIR	=	srcs/
OBJ_DIR	=	dist/

SRCS	=	Calleen.zig
OBJS	=	$(SRCS:%.zig=dist/%.o)

CC		=	/tmp/zig_install/zig-x86_64-linux-0.16.0/zig
CFLAGS	=	build-obj

$(OBJ_DIR)%.o: $(SRC_DIR)%.zig
	@mkdir -p $(OBJ_DIR)
	@if [ ! -f $(CC) ]; then \
		make install_zig; \
	fi
	$(CC) build-obj $< -femit-bin=$@

all: $(NAME)

install_zig:
	@mkdir -p /tmp/zig_install
	wget https://ziglang.org/download/0.16.0/zig-x86_64-linux-0.16.0.tar.xz -O /tmp/zig_install/zig-x86_64-linux-0.16.0.tar.xz
	tar -xf /tmp/zig_install/zig-x86_64-linux-0.16.0.tar.xz -C /tmp/zig_install/
	chmod +x /tmp/zig_install/zig-x86_64-linux-0.16.0/zig

$(NAME): $(OBJS)
	@if [ ! -f $(CC) ]; then \
		make install_zig; \
	fi
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

.PHONY: re fclean clean all install_zig
