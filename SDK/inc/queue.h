#ifndef _XPG_QUEUE_H
#define _XPG_QUEUE_H

#define QUEUESIZE       1000

#ifndef TRUE
#define TRUE (1)
#endif

#ifndef FALSE
#define FALSE (0)
#endif

typedef struct _XpgQueue_t
{
        void * q[QUEUESIZE+1];		/* body of queue */
        int first;                      /* position of first element */
        int last;                       /* position of last element */
        int count;                      /* number of queue elements */
} XpgQueue_t;

void init_queue(XpgQueue_t *q);
void enqueue(XpgQueue_t *q, void * ptr);
void * dequeue(XpgQueue_t *q);
int isEmpty(XpgQueue_t *q);
void print_queue(XpgQueue_t *q);

#endif // _XPG_QUEUE_H