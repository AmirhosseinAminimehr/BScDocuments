using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Shit : MonoBehaviour {

	// Use this for initialization
	void Start () {

	}

	// Update is called once per frame
	void Update () {

	}
	void OnCollisionEnter2D(Collision2D other)
	{
		 if (other.gameObject.tag == "Hunter") {
			Destroy(other.gameObject);
		}
	}
}
