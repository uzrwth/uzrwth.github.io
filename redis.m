.TL
redis

.PP

Redis基于队列串行的文件事件处理机制？

Redis串行化的单线程模型为何能高并发？

说一下Redis节点间的三次握手过程

解释一下Redis基于slots槽位机制的数据分片原理

Redis集群扩容时，slots转移过程

Redis SYNC主从复制的过程了解吗？有什么缺陷？如何解决？

说一下Redis主节点选举算法以及故障转移机制


.PP

The code for commands: server.c



.DS
void echoCommand(client *c) {
    addReplyBulk(c,c->argv[1]);
}
.DE

addReply* must be nonblocking. (addReplyErrorArity, addReplyBulk, addReplyBulkCBuffer, ...)


addReply(): networking.c


.DS
    if (sdsEncodedObject(obj)) {
        _addReplyToBufferOrList(c,obj->ptr,sdslen(obj->ptr));
    } else if (obj->encoding == OBJ_ENCODING_INT) {
        /* For integer encoded strings we just convert it into a string
         * using our optimized function, and attach the resulting string
         * to the output buffer. */
        char buf[32];
        size_t len = ll2string(buf,sizeof(buf),(long)obj->ptr);
        _addReplyToBufferOrList(c,buf,len);
    } else {
        serverPanic("Wrong obj->encoding in addReply()");
    }
.DE



.DS

    if (c->flags & CLIENT_CLOSE_AFTER_REPLY) return;

// push message
    if ((c->flags & CLIENT_PUSHING) && c == server.current_client &&
        server.executing_client && !cmdHasPushAsReply(server.executing_client->cmd))
    {
        _addReplyProtoToList(c,server.pending_push_messages,s,len);
        return;
    }

    if (len > reply_len) _addReplyProtoToList(c,c->reply,s+reply_len,len-reply_len);








    /* Append to tail string when possible. */
    if (tail) {
        /* Copy the part we can fit into the tail, and leave the rest for a
         * new node */
        size_t avail = tail->size - tail->used;
        size_t copy = avail >= len? len: avail;
        memcpy(tail->buf + tail->used, s, copy);
        tail->used += copy;
        s += copy;
        len -= copy;
    }
    if (len) {
        /* Create a new node, make sure it is allocated to at
         * least PROTO_REPLY_CHUNK_BYTES */
        size_t usable_size;
        size_t size = len < PROTO_REPLY_CHUNK_BYTES? PROTO_REPLY_CHUNK_BYTES: len;
        tail = zmalloc_usable(size + sizeof(clientReplyBlock), &usable_size);
        /* take over the allocation's internal fragmentation */
        tail->size = usable_size - sizeof(clientReplyBlock);
        tail->used = len;
        memcpy(tail->buf, s, len);
        listAddNodeTail(reply_list, tail);
        c->reply_bytes += tail->size;

        closeClientOnOutputBufferLimitReached(c, 1);
    }


.DE