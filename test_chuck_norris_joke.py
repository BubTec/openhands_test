import subprocess
import unittest

class TestChuckNorrisJoke(unittest.TestCase):
    def test_joke_output(self):
        result = subprocess.run(['python3', 'chuck_norris_joke.py'], capture_output=True, text=True)
        self.assertIn('Chuck Norris', result.stdout)

if __name__ == '__main__':
    unittest.main()
