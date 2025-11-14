//
// Created by Ali Kooshesh on 11/1/25.
//

#include <iostream>
#include <fstream>

#include "../../../utils/TraceConfig.hpp"
#include<random>
#include<iomanip>

void generateTrace(const unsigned seed,
    const std::size_t n,
    TraceConfig &config,
    std::uniform_int_distribution<int> &dist,
    std::mt19937& gen ) {

    // create and open the output file name
    auto outputFileName = config.makeTraceFileName(seed, n);
    std::cout << "File name: " << outputFileName << std::endl;
    std::ofstream out(outputFileName.c_str());
    if (!out.is_open()) {
        std::cerr << "Failed to open file " << outputFileName << std::endl;
        exit(1);
    }
    out << config.profileName << " " << n << " " << seed << std::endl;

    // Generate N inserts.
    unsigned id = 0;        // id serves as a tiebreaker. Don't use the loop variable for
                            // this purpose because we have multiple loops and could
                            // accidentally generate duplicate IDs.
    int spaceBeforeNumber = 10;
    for (unsigned i = 0; i < n; ++i) {
        out << "I " << std::setw(spaceBeforeNumber) << dist(gen) << std::setw(spaceBeforeNumber) << id++ << "\n";
    }

    // Generate N extracts (Updated for batch-then-drain)
    for (unsigned i = 0; i < n; ++i) {
        out << "E\n";
    }
    out.close();
}

// Use full range 1 to N for batch-then-drain
int choose_key_upper_bound(unsigned int N) {
    return N; 
}   


int main() {

    // TraceConfig provides pre-configured values such as N and seed
    TraceConfig config( std::string("batch_then_drain")); // CHANGED from HUFFMAN
    for (auto seed: config.seeds) {  // currently, we are using one seed only.
        std::mt19937 rng(seed);   // create a random-number generator using "seed"

        for (auto n: config.Ns) {
            //suse the full range [1, N]
            const unsigned key_min = 1, key_max = choose_key_upper_bound(n);
            std::uniform_int_distribution<int> dist(key_min, key_max);

            generateTrace(seed, n, config, dist, rng);
        }

    }

    return 0;
}
