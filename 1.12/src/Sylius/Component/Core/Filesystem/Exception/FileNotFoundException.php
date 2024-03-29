<?php

/*
 * This file is part of the Sylius package.
 *
 * (c) Paweł Jędrzejewski
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare(strict_types=1);

namespace Sylius\Component\Core\Filesystem\Exception;

final class FileNotFoundException extends \RuntimeException
{
    public function __construct(string $fileLocation, ?\Exception $previousException = null)
    {
        parent::__construct(sprintf('File "%s" could not be found.', $fileLocation), 0, $previousException);
    }
}
