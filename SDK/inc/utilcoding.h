#ifndef _UTILCODING_H
#define _UTILCODING_H 1

// return the decoded data length
int encodeInt8(char input, unsigned char *output);

// return the decoded data length
int decodeInt8(const unsigned char *input, char *output);

// return the decoded data length
int encodeUInt8(unsigned char input, unsigned char *output);

// return the decoded data length
int decodeUInt8(const unsigned char *input, unsigned char *output);

// return the decoded data length
int encodeInt16(short input, unsigned char *output);

// return the decoded data length
int decodeInt16(const unsigned char *input, short *output);

// return the decoded data length
int encodeUInt16(unsigned short input, unsigned char *output);

// return the decoded data length
int decodeUInt16(const unsigned char *input, unsigned short *output);

// return the decoded data length
int encodeInt32(int input, unsigned char *output);

// return the decoded data length
int decodeInt32(const unsigned char *input, int *output);

// return the decoded data length
int encodeUInt32(unsigned int input, unsigned char *output);

// return the decoded data length
int decodeUInt32(const unsigned char *input, unsigned int *output);

#endif /* _UTILCODING_H */
