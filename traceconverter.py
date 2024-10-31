# -*- coding: utf-8 -*-

#
# traceconverter.py
#
# ------------------------
# By Øyvind Nohr
# For Inf-2200 Fall 2023
# Based on Øyvind Holmstad's traceconverter.py from 2010
# ------------------------
#
# A script converting a memory trace created with valgrind+lackey to the BYU Address Trace Format
#
# The valgrind command used to produce compatible log trace files:
# ./valgrind --log-file=logfile --tool=lackey --trace-mem=yes [your-program-name]
#
# Output is saved in trace.tr
#

from struct import pack


def main():
    fmt = "<QBBBBL"
    with open("data/cachetest", "r") as logfile:
        with open("trace.tr", "wb") as tracefile:
            for line in logfile:
                if line.startswith("=="):  # Comment
                    continue
                else:  # Memory instruction
                    atype_address_raw, size = line.split(",")
                    raw = atype_address_raw.strip().split(" ")
                    # Atype always first, address last, regardless of  spaces
                    atype = raw[0]
                    # Convert hex-address to int
                    address_hex = raw[-1]
                    address = int(address_hex, 16)
                    size = int(size)

                    # Determine type
                    match atype:
                        case "I":
                            # Instruction read
                            atype = 0
                        case "L":
                            # Data read
                            atype = 1
                        case "S":
                            # Data write
                            atype = 3
                        case _:
                            # M: Data modify
                            continue
                    # Pack to binary and write to file
                    binary = pack(fmt, address, atype, size, 0, 0, 0)
                    tracefile.write(binary)


if __name__ == "__main__":
    main()