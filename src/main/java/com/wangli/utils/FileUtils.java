package com.wangli.utils;

import java.io.File;

public class FileUtils {

    /**
     * 生成默认代码输出目录
     *
     * @param path
     */
    public static void mkdirs(String path) {
        synchronized (path) {
            File f = new File(path);
            if (!f.exists())
                f.mkdirs();
        }
    }
}
