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
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include "tests.cuh"

inline uint64_t getTime()
{
    return std::chrono::time_point_cast<std::chrono::milliseconds>(std::chrono::high_resolution_clock::now()).time_since_epoch().count();
}

void crc32Ex(size_t count, size_t size)
{
    std::vector<std::vector<unsigned char>> buffers = tests::generateBuffers(count, size);

    auto startGPU = getTime(); // Start time for GPU function
    auto resultGPU = tests::testCRC32GPU(buffers); // Call the GPU function
    std::cout << "GPU crc32 Execution Time: " << getTime() - startGPU << " milliseconds" << std::endl; // Execution time of GPU function in milliseconds

    auto startCPU = getTime(); // Start time for CPU function
    auto resultCPU = tests::testCRC32CPU(buffers); // Call the CPU function
    std::cout << "CPU crc32 Execution Time: " << getTime() - startCPU << " milliseconds" << std::endl; // Execution time of CPU function in milliseconds
}

void sha512Ex(size_t count, size_t size)
{
    std::vector<std::vector<unsigned char>> buffers = tests::generateBuffers(count, size);

    auto startGPU = getTime(); // Start time for GPU function
    auto resultGPU = tests::testSHA512GPU(buffers); // Call the GPU function
    std::cout << "GPU sha512 Execution Time: " << getTime() - startGPU << " milliseconds" << std::endl; // Execution time of GPU function in milliseconds

    auto startCPU = getTime(); // Start time for CPU function
    auto resultCPU = tests::testSHA512CPU(buffers); // Call the CPU function
    std::cout << "CPU sha512 Execution Time: " << getTime() - startCPU << " milliseconds" << std::endl; // Execution time of CPU function in milliseconds
}

int main()
{
    crc32Ex(1000, 1000);
    sha512Ex(1000, 1000);
 
    return 0;
}

