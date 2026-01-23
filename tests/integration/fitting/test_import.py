# SPDX-FileCopyrightText: 2021-2026 EasyPeasy contributors <https://github.com/easyscience>
# SPDX-License-Identifier: BSD-3-Clause

import pytest


@pytest.mark.fast
def test_import_easypeasy():
    import easypeasy

    assert easypeasy is not None
