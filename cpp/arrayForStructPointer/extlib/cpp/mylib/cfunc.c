#include <stdio.h>

/**
 * This is an example C library that calls back into Haxe code.
 * The calling back is in indirected through a C++ wrapper function which
 * is passed as the callback function pointer. This callback function expects
 * a baton pointer which is used to pass the Haxe Dynamic function object
 * which is the Haxe function to be called.
 */
void foo(void *baton, void (*callback)(void *baton))
{
    // Simulate some processing...
    // Now call the callback
    printf("foo(C): about to call callback with\n");
    printf("foo(C): callback=%p, baton=%p\n", callback, baton);
    callback(baton);
    printf("foo(C): callback has been called\n");
}
