#!/opt/homebrew/bin/python3
"""
 @Project: Assembler
 @Author: Loyio
 @Date: 2021/1/6
"""

import re

NUM = 1
ID = 2
OP = 3
ERROR = 4


class Lex(object):
    def __init__(self, file_name):
        file = open(file_name, 'r')
        self._lines = file.read()
        self._tokens = self._tokenize(self._lines.split('\n'))
        self.curt_command = []
        self.curt_token = (ERROR, 0)

    def __str__(self):
        pass

    def has_more_commands(self):
        return self._tokens != []

    def next_command(self):
        self.curt_command = self._tokens.pop(0)
        self.next_token()
        return self.curt_command

    def has_next_token(self):
        return self.curt_command != []

    def next_token(self):
        if self.has_next_token():
            self.curt_token = self.curt_command.pop(0)
        else:
            self.curt_token = ERROR, 0
        return self.curt_token

    def peek_token(self):
        if self.has_next_token():
            return self.curt_command[0]
        else:
            return ERROR, 0

    def _tokenize(self, lines):
        return [t for t in [self._tokenize_line(l) for l in lines] if t != []]

    def _tokenize_line(self, line):
        return [self._token(word) for word in self._split(self._remove_comment(line))]

    _comment = re.compile('//.*$')

    def _remove_comment(self, line):
        return self._comment.sub('', line)

    _num_re = r'\d+'
    _id_start = r'\w_.$:'
    _id_re = '[' + _id_start + '][' + _id_start + r'\d]*'
    _op_re = r'[=;()@+\-&|!]'
    _word = re.compile(_num_re + '|' + _id_re + '|' + _op_re)

    def _split(self, line):
        return self._word.findall(line)

    def _token(self, word):
        if self._is_num(word): return NUM, word
        if self._is_id(word): return ID, word
        if self._is_op(word):
            return OP, word
        else:
            return ERROR, word

    def _is_op(self, word):
        return self._is_match(self._op_re, word)

    def _is_num(self, word):
        return self._is_match(self._num_re, word)

    def _is_id(self, word):
        return self._is_match(self._id_re)

    def _is_match(self, re_str, word):
        return re.match(re_str, word) != None
