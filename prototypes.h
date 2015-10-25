
union constant{
	int ival;
	char cval;
	char *sval;
	char sname[10];
};

typedef struct SYM_TAB{
	int datatype;
	union constant val;
	char *symbol_name;
	struct SYM_TAB *next;
} SYM_TAB;

typedef struct nodeType{
	// 0 for constant
	// 1 for variable
	// 2 for operator
	int typo;
	int datatype;
	union {
		SYM_TAB *sym_ptr;
		union constant val;
	};
	struct nodeType *left,*right;

} nodeType;