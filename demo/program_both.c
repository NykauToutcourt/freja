/*
 This file is part of Freja.

 Freja is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 Freja is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with Freja. If not, see <http://www.gnu.org/licenses/>.

*/



#include <stdio.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define ENTROPY 0.1
/* to be defined at compile-time:
 * NB_THREADS
 */

#if NB_THREADS > 0
typedef struct
{
  int id;
  unsigned long long int count;
} thread_do_some_work_arg;
#endif

static int
do_some_work(unsigned long long int count)
{
  unsigned long long int i;

  // Bring it on, yeah!
  for (i = 0; i < count; i++)
    ;

  return 0;
}

#if NB_THREADS > 0
static void*
thread_do_some_work(void* arg)
{
  thread_do_some_work_arg *args;
  args = (thread_do_some_work_arg*) arg;

  do_some_work(args->count);

  return NULL;
}
#endif

static unsigned long long int
variate(unsigned long long int count, float entropy)
{
  unsigned long long int variation, res;
  variation = (unsigned long long int) ((((float) (random() % RAND_MAX)) / RAND_MAX) * count
      * entropy);

  res = (unsigned long long int) (((float) (count + variation)) / (NB_THREADS
      == 0 ? 1 : NB_THREADS));

  return res;
}

static int
do_work(unsigned long long int count, float entropy)
{
#if NB_THREADS > 0
  pthread_t thread[NB_THREADS];
  pthread_attr_t attr;
  thread_do_some_work_arg arg[NB_THREADS];
  int i;

  pthread_attr_init(&attr);
  for (i = 0; i < NB_THREADS; i++)
    {
      arg[i].id = i;
      arg[i].count = variate(count, entropy);

      pthread_create(&thread[i], &attr, thread_do_some_work, (void*) &arg[i]);
    }

  for (i = 0; i < NB_THREADS; i++)
    {
      pthread_join(thread[i], NULL);
    }
#else
  count = variate(count, entropy);
  do_some_work(count);
#endif
  return 0;
}

int
main(int argc, char ** argv)
{
  unsigned long long int count;

  srandom(time(NULL));
  count = atoi(argv[1]);
  do_work(count, ENTROPY);

  // Simulate occasional running failures
  srand(time(NULL));
  return !(random() % 6);
}
