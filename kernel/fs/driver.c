/**
 * ��Դ�����׵Ŀγ�Ϊ - ��0��1����дFAT32�ļ�ϵͳ��ÿ�����̶�Ӧһ����ʱ��������ע�͡�
 * ���ߣ�����ͭ
 * �γ���ַ��http://01ketang.cc
 * ��Ȩ��������Դ��ǿ�Դ�����ο���������������ǰ����ϵ���ߡ�
 */
#include <stdio.h>
#include <time.h>
#include "xdisk.h"
#include "xfat.h"

/**
 * ��ʼ�������豸
 * @param disk ��ʼ�����豸
 * @param name �豸������
 * @return
 */
static xfat_err_t xdisk_hw_open(xdisk_t *disk, void *init_data)
{
    const char *path = (const char *)init_data;

    FILE *file = fopen(path, "rb+");
    if (file == NULL)
    {
        printf("open disk failed:%s\n", path);
        return FS_ERR_IO;
    }

    disk->data = file;
    disk->sector_size = 512;

    fseek(file, 0, SEEK_END);
    disk->total_sector = ftell(file) / disk->sector_size;
    return FS_ERR_OK;
}

/**
 * �رմ洢�豸
 * @param disk
 * @return
 */
static xfat_err_t xdisk_hw_close(xdisk_t *disk)
{
    FILE *file = (FILE *)disk->data;
    fclose(file);

    return FS_ERR_OK;
}

/**
 * ���豸�ж�ȡָ����������������
 * @param disk ��ȡ�Ĵ���
 * @param buffer ��ȡ���ݴ洢�Ļ�����
 * @param start_sector ��ȡ����ʼ����
 * @param count ��ȡ����������
 * @return
 */
static xfat_err_t xdisk_hw_read_sector(xdisk_t *disk, u8_t *buffer, u32_t start_sector, u32_t count)
{
    u32_t offset = start_sector * disk->sector_size;
    FILE *file = (FILE *)disk->data;

    int err = fseek(file, offset, SEEK_SET);
    if (err == -1)
    {
        printf("seek disk failed:0x%x\n", (int)offset);
        return FS_ERR_IO;
    }

    err = (int)fread(buffer, disk->sector_size, count, file);
    if (err == -1)
    {
        printf("read disk failed:sector:%d, count:%d\n", (int)start_sector, (int)count);
        return FS_ERR_IO;
    }
    return FS_ERR_OK;
}

/**
 * ���豸��дָ������������������
 * @param disk д��Ĵ洢�豸
 * @param buffer ����Դ������
 * @param start_sector д�����ʼ����
 * @param count д���������
 * @return
 */
static xfat_err_t xdisk_hw_write_sector(xdisk_t *disk, u8_t *buffer, u32_t start_sector, u32_t count)
{
    u32_t offset = start_sector * disk->sector_size;
    FILE *file = (FILE *)disk->data;

    int err = fseek(file, offset, SEEK_SET);
    if (err == -1)
    {
        printf("seek disk failed: 0x%x\n", (int)offset);
        return FS_ERR_IO;
    }

    err = (int)fwrite(buffer, disk->sector_size, count, file);
    if (err == -1)
    {
        printf("write disk failed:sector:%d, count:%d\n", (int)start_sector, (int)count);
        return FS_ERR_IO;
    }

    // ˢ��һ�£���ʱд��
    fflush(file);
    return FS_ERR_OK;
}

/**
 * ��ȡ��ǰʱ��
 * @param timeinfo ʱ��洢��������
 * @return
 */
static xfat_err_t xdisk_hw_curr_time(xdisk_t *disk, xfile_time_t *timeinfo)
{
    time_t raw_time;
    struct tm *local_time;

    // ��ȡ����ʱ��
    time(&raw_time);
    local_time = localtime(&raw_time);

    // ����ת��
    timeinfo->year = local_time->tm_year + 1900;
    timeinfo->month = local_time->tm_mon + 1;
    timeinfo->day = local_time->tm_mday;
    timeinfo->hour = local_time->tm_hour;
    timeinfo->minute = local_time->tm_min;
    timeinfo->second = local_time->tm_sec;

    return FS_ERR_OK;
}

/**
 * ������������ṹ
 */
xdisk_driver_t vdisk_driver = {
    .open = xdisk_hw_open,
    .close = xdisk_hw_close,
    .read_sector = xdisk_hw_read_sector,
    .write_sector = xdisk_hw_write_sector,
    .curr_time = xdisk_hw_curr_time,
};