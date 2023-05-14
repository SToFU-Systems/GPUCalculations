/*
 *
 *  Copyright (C) 2023, SToFU Systems S.L.
 *  All rights reserved.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 */
#include "crc32.cuh"

namespace crc32
{
    /*
    * FUNCTION: __device__ __host__ uint32_t crc32
    *
    * ARGS:
    * const uint8_t* buffer - Input buffer containing data for CRC32 calculation.
    * int size - Size of the input buffer.
    *
    * DESCRIPTION:
    * This function calculates the CRC32 checksum for a given input buffer on both CPU and GPU devices.
    * The CRC32 calculation algorithm used is the standard CRC32 polynomial with initial value of 0xFFFFFFFF and final XOR of 0xFFFFFFFF.
    * The function iterates through each byte in the input buffer using a for loop, performing bitwise XOR and shift operations to calculate the CRC32 value.
    * The calculated CRC32 value is then bitwise negated (~crc) and returned as the final result.
    *
    * RETURN VALUE:
    * uint32_t - The calculated CRC32 checksum for the input buffer.
    * This function returns a 32-bit unsigned integer representing the CRC32 checksum value.
    */
    __device__ __host__ uint32_t crc32(const uint8_t* buffer, int size)
    {
        uint32_t crc = 0xFFFFFFFF;
        for (int i = 0; i < size; ++i)
        {
            crc ^= buffer[i];
            for (int j = 0; j < 8; ++j)
                crc = (crc >> 1) ^ (0xEDB88320 & (-(crc & 1)));
        }
        return ~crc;
    }

    /*
    * FUNCTION: __global__ void crc32Kernel
    *
    * ARGS:
    * In uint8_t* buffers - Input buffer containing data for CRC32 calculation.
    * Out uint32_t* crcResults - Output buffer to store CRC32 results.
    * int numBuffers - Number of input buffers.
    * int bufferSize - Size of each input buffer.
    *
    * DESCRIPTION:
    * This is a CUDA kernel function for calculating CRC32 checksums in parallel on a GPU device.
    * Each thread in the GPU grid corresponds to a unique thread identifier (tid) calculated from blockIdx.x and blockDim.x.
    * The bufferIndex is calculated based on tid and bufferSize to determine the starting index of the current buffer to be processed.
    * The function performs CRC32 calculation on each buffer by iterating through each byte in the buffer using a for loop.
    * The calculated CRC32 value is then saved to the crcResults array at the corresponding tid index.
    *
    * RETURN VALUE: void
    * This function does not return a value.
    */
    __global__ void crc32Kernel(_In_ const uint8_t* buffers, _Out_ uint32_t* crcResults, int numBuffers, int bufferSize)
    {
        /* Calculate unique thread identifier */
        int tid = blockIdx.x * blockDim.x + threadIdx.x;
        /* Calculate index of the current buffer */
        int bufferIndex = tid * bufferSize;

        /* Check if buffer index is within valid range */
        if (bufferIndex < numBuffers * bufferSize)
            /* Call crc32 function to calculate CRC32 for the current buffer */
            crcResults[tid] = crc32(buffers + bufferIndex, bufferSize);
    }
}