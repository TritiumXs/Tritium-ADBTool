# -*-Coding = UTF-8-*-
# Wrinteen by GitHub@TritiumXs

def title(word, symbol="=", symbol_length=40, space=True):
    if space:
        print()
    word_length = len(word)
    length = int((symbol_length - word_length) / 2)
    print(symbol * length + word + symbol * length)


def format(title, string, tabs=2, unit=""):
    print(title + "\t" * tabs, str(string) + unit)


def input(tips="", symbol="=", length=40, inp="=> "):
    print(tips + symbol * (length - len(tips)))
    print()
    print(symbol * length, end="", flush=True)
    input_str = input("\r\033[1A" + inp)
    return input_str


def total_title(word, symbol="=", symbol_length=40, fill=False):
    word_length = len(word)
    length = int((symbol_length - word_length) / 2)
    print(symbol * symbol_length)
    if fill:
        print(symbol * length + word + symbol * length)
    else:
        print(" " * length + word + " " * length)
    print(symbol * symbol_length)


def p_tips(word, mode="info", fill=1):
    fill_str = {"warning": "[!]", "error": "[X]", "info": "[i]", "question": "[?]"}
    fill_color = {"warning": ["\033[0m", "\033[0;33m", "\033[0;30;43"],
                  "error": ["\033[0m", "\033[0;31m", "\033[0;30;41"], "info": ["\033[0m", "\033[0;32m", "\033[0;30;42"],
                  "question": ["\033[0m", "\033[0;36m", "\033[0;30;46"]}

    if fill == 0:
        print(fill_color[mode][0] + fill_str[mode] + fill_color[mode][0], word + fill_color[mode][0])
    elif fill == 1:
        print(fill_color[mode][1] + fill_str[mode] + fill_color[mode][0], word + fill_color[mode][0])
    elif fill == 2:
        print(fill_color[mode][1] + fill_str[mode] + fill_color[mode][1], word + fill_color[mode][1])
    elif fill == 3:
        print(fill_color[mode][2] + fill_str[mode] + fill_color[mode][2], word + fill_color[mode][2])
