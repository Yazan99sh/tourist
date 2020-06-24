<?php

namespace App\Repository;

use App\Entity\RatingsEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;

/**
 * @method RatingsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RatingsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RatingsEntity[]    findAll()
 * @method RatingsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RatingsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RatingsEntity::class);
    }

    // /**
    //  * @return RatingsEntity[] Returns an array of RatingsEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('r.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?RatingsEntity
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}