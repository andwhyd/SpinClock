from itertools import permutations
import multiprocessing


# partsAllV = ["-----","#####", "####-", "-####", "###-#", "#-###", "##-##",
#          "###--", "--###", "##-#-", "-#-##", "-##-#", "#-##-", "##--#", "#--##", "#-#-#", "-###-",
#          "##---", "---##", "-##--", "--##-", "#-#--", "--#-#", "#--#-", "-#--#", "#---#", "-#-#-",
#          "#----", "-#---", "--#--", "---#-", "----#"]
# partsMinV = ["-----","#####", "####-", "-####", "###-#", "#-###", "##-##",
#           "###--", "##--#", "#--##", "#-#-#", "-###-",
#           "##---", "---##", "-##--", "--##-", "#-#--", "--#-#", "#--#-", "-#--#", "#---#", "-#-#-",
#           "#----", "-#---", "--#--", "---#-", "----#"]
partsAllH = ["---","###", "#-#", "##-", "-##", "#--", "-#-", "--#"]

def compress_two(a, b):
    for i in range(len(b), -1, -1):
        if b in a + b[i:]:
            return a + b[i:]


def compress(items):
    it = iter(items)
    res = next(it)
    for i in it:
        res = compress_two(res, i)
    return res


shortest = float("inf")
shortestres = ""

if __name__ == "__main__":
    with multiprocessing.Pool() as pool:  # default is optimal number of processes
        results = pool.imap_unordered(compress, permutations(partsAllH,len(partsAllH)))
        for res in results:
            if len(res) < shortest:
                shortest = len(res)
                shortestres = res

print('"{}" {} chars'.format(shortestres, shortest))