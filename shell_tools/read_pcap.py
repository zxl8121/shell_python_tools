#!/usr/bin/python
# -*- coding: UTF-8 -*-
import argparse
import shutil
import os
import time
from subprocess import Popen

class ReadPcap(object):
    def __init__(self, pcap_path, copy_path, counts, seconds):
        self.records = []
        self.pcap_path = pcap_path
        self.copy_path = copy_path
        self.counts = int(counts)
        self.seconds = int(seconds)
        self.pcap_counts = 0
        self.total_counts = 0
        self.read_recodes()

    def read_recodes(self):
        if self.pcap_path is not None:
            config_file = self.pcap_path + '/../records.txt'
            try:
                self.total_counts = 0
                with open(config_file, 'rb') as f:
                    for line in f.readlines():
                        self.records.append(line.strip())
                        self.total_counts += 1
            except Exception as e:
                print e

    def read_pcaps(self):
        flag = False
        config_file = self.pcap_path + '/../records.txt'
        records_fp = open(config_file, 'ab')
        self.pcap_counts = 0
        cmd = 'chmod -R +x ' + self.pcap_path
        os.popen(cmd)
        for root, dir, files in os.walk(self.pcap_path):
            for file in files:
                if not file.endswith('cap'):
                    continue
                if file in self.records:
                    continue
                f_src = os.path.join(root, file)
                f_dst = os.path.join(self.copy_path, file)
                ##fn2 = os.path.abspath(file)
                ##print fn, fn2 
                try:     
                    shutil.copy(f_src, f_dst)
                    self.pcap_counts += 1
                    self.total_counts += 1
                except OSError as e:
                    print e, 'please check, process will run after %d seconds.'%(self.seconds) 
                    flag = True
                    break
                records_fp.write(file + '\n') 
                if self.pcap_counts >= self.counts:
                    flag = True
                    break
            if flag:
                break
        records_fp.close()
        print 'pcap_counts = %d, total_counts = %d'%(self.pcap_counts, self.total_counts)              
def main():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('-s',  dest = 'spath',     help = 'Path to Pcap.',     default = '/home/zxl/pcap')
    arg_parser.add_argument('-d',  dest = 'dpath',     help = 'Path to copy.',     default = '/data/serverids_pcaps')
    arg_parser.add_argument('-c',  dest = 'counts',     help = 'Copy file counts onece.',     default = 10000)
    arg_parser.add_argument('-t',  dest = 'seconds',     help = 'Sleep time onece.',     default = 10)

    args = arg_parser.parse_args()
    readPcap = ReadPcap(args.spath, args.dpath, args.counts, args.seconds)
    while True:
        #readPcap.read_recodes()
        readPcap.read_pcaps()
        time.sleep(readPcap.seconds)

if __name__ == "__main__":
    main()
