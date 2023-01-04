#
# Copyright (c) 2022, NVIDIA CORPORATION.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#!/bin/bash
set -e

cd /Merlin

container=$1
devices=$2

# Run only for Merlin Tensorflow Container
if [ "$container" == "merlin-tensorflow" ]; then
    # feast will install latest pyarrow version (currently 10.0.1)
    # this vesrion of pyarrow is incompatibile
    # with the current version of cudf 22.12
    # pinning the version of pyarrow here to match the cudf-supported version
    pip install 'feast<0.20' pyarrow==8.0.0
    pip install dask==2022.07.1 distributed==2022.07.1
    CUDA_VISIBLE_DEVICES="$devices"  pytest -rxs tests/integration
fi