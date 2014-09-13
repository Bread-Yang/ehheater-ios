#ifndef _LINKLIST_H_
#define _LINKLIST_H_

typedef void LinkList;
typedef void LinkListNode;

extern LinkListNode* LinkList_Find(LinkList* list, LinkListNode* node);

extern LinkList* LinkList_Create();

extern void LinkList_Destroy(LinkList* list);

extern void LinkList_Clear(LinkList* list);

extern int LinkList_Length(LinkList* list);

extern int LinkList_Insert(LinkList* list, LinkListNode* node, int pos);

extern LinkListNode* LinkList_Get(LinkList* list, int pos);

extern LinkListNode* LinkList_Delete(LinkList* list, int pos);

extern void LinkList_Reverse(LinkList* list);

#endif